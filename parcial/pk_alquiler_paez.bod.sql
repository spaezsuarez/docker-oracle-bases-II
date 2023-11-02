create or replace PACKAGE BODY PK_ALQUILER_PAEZ AS 
 /*-----------------------------------------------------------------------------------
  Proyecto   : Reservas de vehículos. Curso BDII
  Descripcion: Paquete que contiene las variables globales, funciones y procedimientos
               asociados al módulo de Reservas
  Autor      : Alba Consuelo Nieto.
--------------------------------------------------------------------------------------
*/

    /*-----------------------------------------------------------------------------------------
     Función para buscar una reserva
     
     Parametros de Entrada  : pk_reserva         Id de la reserva
     Parametros de Salida   : pc_error           codigo de error (1 si no existe la reserva, de lo contrario 0)
                              pm_error           Mensaje de error, en caso de no haber el valor es null
     Retorna                : un registro de tipo RESERVA (RESERVA%ROWTYPE)
     Excepcion              : En caso de no encontrar la reserva
   */
    FUNCTION FU_BUSCAR_RESERVA(pk_reserva IN  RESERVA.K_RESERVA%TYPE,
                              pc_error OUT NUMBER,
                              pm_error OUT VARCHAR) RETURN RESERVA%ROWTYPE
    IS
        lc_reserva RESERVA%ROWTYPE;
    BEGIN
        pc_error := 0;
        pm_error := null;
        SELECT * into lc_reserva FROM RESERVA r where r.K_RESERVA = pk_reserva;
        RETURN lc_reserva;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        pc_error := 1;
        pm_error := 'Reserva no encontrada';
        RAISE_APPLICATION_ERROR(-20001, 'Reserva no encontrado');
    END FU_BUSCAR_RESERVA;


    /*-----------------------------------------------------------------------------------------
     Procedimiento para recalcular el precio del alquilar de cada uno de los vehiculos de una reserva dado
     un IVA como parametro
     Parametros de Entrada  : pk_reserva        Id de la reserva
                              pv_iva            iVA A APLICAR EN EL VALOR DE LA RESERVA (multiplo de 100)
                              pi_actualiza      varchar para indicar si debe actualizar o no
     Parametros de Salida:    pc_error       = 1 si hay algun error,
                                               0, en caso contrario
                              pm_error         Mensaje de error si hay error o null en caso contrario
   */
    PROCEDURE PR_CALCULAR_IVA_RESERVA(pk_reserva   IN RESERVA.K_RESERVA%TYPE,
                                     pv_iva       IN NUMBER,
                                     pi_actualizar IN VARCHAR,
                                     pc_error     OUT NUMBER, 
                                     pm_error     OUT VARCHAR)
    IS
        l_reserva RESERVA%ROWTYPE;
        lv_nombre_cliente VARCHAR(100);
        CURSOR c_vehiculos_reserva(ck_reserva RESERVA.K_RESERVA%TYPE) IS SELECT VR.K_PLACA,VR.K_RESERVA,VR.V_ALQUILER  FROM VEHICULO_RESERVA vr WHERE VR.K_RESERVA = ck_reserva;
        lc_vehiculo_reserva c_vehiculos_reserva%ROWTYPE;
        lq_valor_nuevo VEHICULO_RESERVA.V_ALQUILER%TYPE;
        lq_valor_nuevo_reserva RESERVA.V_TOTAL%TYPE := 0;
    BEGIN
        pc_error := 0;
        pm_error := null;
        l_reserva := FU_BUSCAR_RESERVA(pk_reserva,pc_error,pm_error);
        IF pi_actualizar IN ('S','N') THEN
            l_reserva := FU_BUSCAR_RESERVA(pk_reserva,pc_error,pm_error);
            IF pc_error = 0 THEN
                SELECT N_NOMBRE1||' '||N_NOMBRE2||' '||N_APELLIDO1||' '||N_APELLIDO2 INTO lv_nombre_cliente FROM CLIENTE c where c.K_CODCLIENTE = l_reserva.K_CODCLIENTE;
                DBMS_OUTPUT.PUT_LINE('Nro_reserva: '||l_reserva.K_RESERVA);
                DBMS_OUTPUT.PUT_LINE('Fecha Reserva: '||TO_CHAR(l_reserva.F_RESERVA,'DD-MON-YYYY'));
                DBMS_OUTPUT.PUT_LINE('Cliente: '||lv_nombre_cliente);
                DBMS_OUTPUT.PUT_LINE('Nro Matricula             '||'Valor Anterior              '||'Nvo Valor');
                DBMS_OUTPUT.PUT_LINE('=============             '||'==============              '||'============');
                FOR lc_vehiculo_reserva IN c_vehiculos_reserva(l_reserva.K_RESERVA) LOOP
                    lq_valor_nuevo := lc_vehiculo_reserva.V_ALQUILER + (lc_vehiculo_reserva.V_ALQUILER*(pv_iva/100));
                    lq_valor_nuevo_reserva := lq_valor_nuevo_reserva + lq_valor_nuevo;
                    DBMS_OUTPUT.PUT_LINE(lc_vehiculo_reserva.K_PLACA||'             '||lc_vehiculo_reserva.V_ALQUILER||'                '||lq_valor_nuevo);
                    IF pi_actualizar = 'S' THEN
                        UPDATE VEHICULO_RESERVA SET V_ALQUILER=lq_valor_nuevo WHERE K_PLACA=lc_vehiculo_reserva.K_PLACA AND K_RESERVA=lc_vehiculo_reserva.K_RESERVA;
                        COMMIT;
                    END IF;
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('Valor anterior (sin iva)'||l_reserva.V_TOTAL);
                DBMS_OUTPUT.PUT_LINE('Nuevo Valor (con iva '||pv_iva||'%) '||lq_valor_nuevo_reserva);
            END IF;
            pc_error := 0;
            pm_error := null;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Parametro de actualización invalido');
            pc_error := 1;
            pm_error := 'Parametro de actualización invalido';
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          pc_error := 1;
          pm_error := 'Cliente no existe';
          ROLLBACK;
    END PR_CALCULAR_IVA_RESERVA;

END PK_ALQUILER_PAEZ;