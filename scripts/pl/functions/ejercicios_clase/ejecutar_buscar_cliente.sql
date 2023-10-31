DECLARE
   l_codcliente CLIENTE.K_CODCLIENTE%TYPE := 101;
   pc_error VARCHAR(250);
   pm_error VARCHAR(250);
BEGIN
   DBMS_OUTPUT.PUT_LINE(FU_BUSCAR_CLIENTE(l_codcliente,pc_error,pm_error));
   DBMS_OUTPUT.PUT_LINE(pm_error);
END;
/