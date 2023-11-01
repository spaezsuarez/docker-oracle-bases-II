CREATE OR REPLACE PACKAGE PK_ALQUILER_TALLER AS 
/*-----------------------------------------------------------------------------------
  Proyecto   : Reservas de vehículos. Curso BDII
  Descripcion: Paquete que contiene las variables globales, funciones y procedimientos
               asociados al módulo de Reservas
  Autor	     : Alba Consuelo Nieto.
--------------------------------------------------------------------------------------*/
   --Declaración del tipo registro con los datos básicos de un cliente
   TYPE gtr_cliente IS RECORD(
     k_codcliente       cliente.k_codcliente%TYPE,
     i_tipoId           NUMBER(5),
     q_identificacion   cliente.q_identificacion%TYPE,
     n_nombre1          cliente.n_nombre1%TYPE,
     n_nombre2          cliente.n_nombre2%TYPE,
     n_apellido1        cliente.n_apellido1%TYPE,
     n_apellido2        cliente.n_apellido2%TYPE
     );
     -- Variable global de tipo registro cliente
     gr_cliente gtr_cliente;
     --Variables globales: Estado de la reserva
     gv_cancelada  CHAR  := 'C'; 
     gv_activa     CHAR  := 'A';
     gv_pagada     CHAR  :=  'P';

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
                                pm_error        OUT VARCHAR);

     /*------------------------------------------------------------------------------
     Función para retornar el código de un cliente
     Parametros de Entrada  : pi_tipoId         Tipo de identificación del cliente
                              pq_identificacion Número de identificación del cliente  
     Retorna                : Código del cliente 
     Excepcion              : En caso de no encontrar el cliente
    */
    FUNCTION FU_BUSCAR_CLIENTE(pi_tipoId         IN cliente.i_tipoId%TYPE,
                               pq_identificacion IN cliente.q_identificacion%TYPE) RETURN NUMBER;

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
   PROCEDURE PR_LISTAR_RESERVAS(pi_tipoId         IN cliente.i_tipoId%TYPE,
                                pq_identificacion IN cliente.q_identificacion%TYPE, 
                                pc_error          OUT NUMBER, 
                                pm_error          OUT VARCHAR);
   /*-----------------------------------------------------------------------------------------
     Función para validar si un vehículo está disponible para reservar en una fecha dada.
     
     Parametros de Entrada  : pk_placa         placa del vehiculo
                              pf_fecha         Fecha en la cual se valida la disponibilidad del vehiculo
     Retorna                : Booleano para indicar la disponibilidad del vehiculo
     Excepcion              : En caso de no encontrar el vehiculo
   */
   FUNCTION FU_VEHICULO_DISPONIBLE(pk_placa IN  VEHICULO.K_PLACA%TYPE,
                                   pf_fecha IN  RESERVA.F_RESERVA%TYPE)  RETURN BOOLEAN;

END PK_ALQUILER_TALLER;