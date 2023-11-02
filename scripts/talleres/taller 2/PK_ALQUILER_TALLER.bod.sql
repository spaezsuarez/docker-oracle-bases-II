create or replace PACKAGE BODY PK_ALQUILER_TALLER AS 
 /*-----------------------------------------------------------------------------------
  Proyecto   : Reservas de vehículos. Curso BDII
  Descripcion: Paquete que contiene las variables globales, funciones y procedimientos
               asociados al módulo de Reservas
  Autor      : Alba Consuelo Nieto.
--------------------------------------------------------------------------------------
    */
     /*------------------------------------------------------------------------------
     Procedimiento para buscar los datos básicos de un cliente
     Parametros de Entrada: pk_codcliente    Código del cliente a buscar
     Parametros de Salida:  pr_cliente       Registro con los datos básicos del cliente
                            pc_error        = 1 si no existe,
                                             0, en caso contrario
                            pm_error         Mensaje de error si hay error o null en caso contrario
    */
    PROCEDURE PR_BUSCAR_CLIENTE(pk_codcliente   IN cliente.k_codcliente%TYPE,
                                pr_cliente      OUT gtr_cliente,
                                pc_error        OUT NUMBER,
                                pm_error        OUT VARCHAR)
    IS
    BEGIN
     pc_error := null;
     pm_error := 0; 
    
     SELECT k_codcliente, i_tipoId, q_identificacion,n_nombre1, n_nombre2, n_apellido1, n_apellido2  INTO
             pr_cliente.k_codcliente,
             pr_cliente.i_tipoId,
             pr_cliente.q_identificacion,
             pr_cliente.n_nombre1,
             pr_cliente.n_nombre2,
             pr_cliente.n_apellido1,
             pr_cliente.n_apellido2
     FROM cliente WHERE k_codcliente = pk_codcliente;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
          pc_error := 1;
          pm_error := 'Cliente no existe';
    END PR_BUSCAR_CLIENTE;

     /*------------------------------------------------------------------------------
     Función para retornar el código de un cliente
     Parametros de Entrada  : pi_tipoId         Tipo de identificación del cliente
                              pq_identificacion Número de identificación del cliente  
     Retorna                : Código del cliente 
     Excepcion              : En caso de no encontrar el cliente
    */
    FUNCTION FU_BUSCAR_CLIENTE(pi_tipoid         IN cliente.i_tipoid%TYPE,
                               pq_identificacion IN cliente.q_identificacion%TYPE) RETURN NUMBER
    IS
    --Declaración de variables locales
        lk_codcliente cliente.k_codcliente%TYPE;
    BEGIN
        SELECT k_codcliente INTO  lk_codcliente FROM cliente
        WHERE i_tipoId = pi_tipoid AND q_identificacion = pq_identificacion; 
        RETURN lk_codcliente;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cliente no encontrado');
    END FU_BUSCAR_CLIENTE;                    

    /*-----------------------------------------------------------------------------------------
     Procedimiento para listar las reservas de un cliente.
     Debe mostrar el código, identificación,nombre y apellido del cliente. 
     Para cada reserva se debe mostrar el código, fecha inicial, fecha final, valor y estado
     de la reserva, y para cada reserva se muestran los vehículos reservados: placa, fecha 
     de entrega y devolución, y el valor de alquiler del vehículo.
     Parametros de Entrada  : pi_tipoId         Tipo de identificación del cliente
                              pq_identificacion Número de identificación del cliente  
     Parametros de Salida:    pc_error       = 1 si no existe el cliente,
                                               0, en caso contrario
                              pm_error         Mensaje de error si hay error o null en caso contrario
   */
    PROCEDURE PR_LISTAR_RESERVAS(pi_tipoid        IN cliente.i_tipoid%TYPE,
                                pq_identificacion IN cliente.q_identificacion%TYPE, 
                                pc_error          OUT NUMBER, 
                                pm_error          OUT VARCHAR)
    IS
        CURSOR c_reservas(ck_cliente CLIENTE.K_CODCLIENTE%TYPE) IS SELECT K_RESERVA,F_INICIAL,F_FINAL,V_TOTAL,I_ESTADO FROM RESERVA WHERE K_CODCLIENTE = ck_cliente;
        CURSOR c_vehiculos(ck_reserva RESERVA.K_RESERVA%TYPE) IS SELECT v.k_placa,vr.f_entrega,vr.f_devolucion,vr.v_alquiler FROM VEHICULO v INNER JOIN VEHICULO_RESERVA vr ON V.K_PLACA = VR.K_PLACA WHERE VR.K_RESERVA = ck_reserva;
        lc_reservas c_reservas%ROWTYPE;
        lc_vehiculos c_vehiculos%ROWTYPE;
        l_cliente CLIENTE%ROWTYPE;
    BEGIN
        pc_error := 0;
        pm_error := '';
        select * INTO l_cliente from cliente cl where cl.i_tipoid = pi_tipoid and cl.q_identificacion = pq_identificacion;
        IF l_cliente.k_codcliente IS NULL THEN
            RAISE NO_DATA_FOUND;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Cod cliente: '|| l_cliente.k_codcliente);
        DBMS_OUTPUT.PUT_LINE('Identificación Cliente: '|| l_cliente.q_identificacion);
        DBMS_OUTPUT.PUT_LINE('Nombre Cliente: '|| l_cliente.N_NOMBRE1 || ' ' || l_cliente.N_NOMBRE2);
        DBMS_OUTPUT.PUT_LINE('Apellido Cliente: '|| l_cliente.N_APELLIDO1 || ' ' || l_cliente.N_APELLIDO2);
        FOR lc_reservas IN c_reservas(l_cliente.k_codcliente) LOOP
            DBMS_OUTPUT.PUT_LINE('RESERVA: '||lc_reservas.K_RESERVA||' '||lc_reservas.F_INICIAL||' '||lc_reservas.F_FINAL||' '||lc_reservas.V_TOTAL||' '||lc_reservas.I_ESTADO);
            FOR lc_vehiculos IN c_vehiculos(lc_reservas.K_RESERVA) LOOP
                DBMS_OUTPUT.PUT_LINE('VEHICULO: '||lc_vehiculos.k_placa||' '||lc_vehiculos.f_entrega||' '||lc_vehiculos.f_devolucion||' '||lc_vehiculos.v_alquiler);
            END LOOP;
        END LOOP;
        pc_error := 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          pc_error := 1;
          pm_error := 'Cliente no existe';
    END PR_LISTAR_RESERVAS;                    


   /*-----------------------------------------------------------------------------------------
     Función validar si un vehículo está disponible para reservar en una fecha dada.
     
     Parametros de Entrada  : pk_placa         placa del vehiculo
                              pf_fecha         Fecha en la cual se valida la disponibilidad del vehiculo
     Retorna                : Booleano para indicar la disponibilidad del vehiculo 
     Excepcion              : En caso de no encontrar el vehiculo
   */
    FUNCTION FU_VEHICULO_DISPONIBLE(pk_placa IN VEHICULO.K_PLACA%TYPE,
                                   pf_fecha IN  RESERVA.F_RESERVA%TYPE) RETURN BOOLEAN
    AS
        l_vehiculo VEHICULO%ROWTYPE;
        lf_fecha_reserva RESERVA.F_RESERVA%TYPE := NULL;
    BEGIN
        SELECT V.* INTO  l_vehiculo FROM VEHICULO V WHERE V.K_PLACA = pk_placa;
        SELECT r.f_reserva into lf_fecha_reserva FROM vehiculo_reserva vr
        INNER JOIN reserva r on vr.k_reserva = r.k_reserva  
        where vr.k_placa = pk_placa
        and r.f_reserva = pf_fecha;
        IF lf_fecha_reserva IS NULL THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Vehiculo no encontrado');
    END FU_VEHICULO_DISPONIBLE;

END PK_ALQUILER_TALLER;