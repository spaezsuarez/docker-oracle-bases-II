DECLARE
   pk_reserva RESERVA.K_RESERVA%TYPE := 20231;
   pv_iva NUMBER := 19;
   pi_actualizar VARCHAR(1) := 'S';
   pc_error VARCHAR(250);
   pm_error VARCHAR(250);
BEGIN
    PK_ALQUILER_PAEZ.PR_CALCULAR_IVA_RESERVA(pk_reserva,pv_iva,pi_actualizar,pc_error,pm_error);
END;
/