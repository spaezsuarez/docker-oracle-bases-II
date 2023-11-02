CREATE OR REPLACE PACKAGE PK_ALQUILER_PAEZ AS 
/*-----------------------------------------------------------------------------------
  Proyecto   : Reservas de vehículos. Curso BDII PARCIAL 2
  Descripcion: Paquete que contiene funciones y procedimientos para el parcial
  Autor	     : Sergio Paez - 20191020167
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
                              pm_error OUT VARCHAR) RETURN RESERVA%ROWTYPE;

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
                                     pm_error     OUT VARCHAR);
   

END PK_ALQUILER_PAEZ;