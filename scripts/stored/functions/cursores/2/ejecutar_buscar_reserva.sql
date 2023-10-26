DECLARE
   l_codcliente CLIENTE.K_CODCLIENTE%TYPE := 101;
   pc_error VARCHAR(250);
   pm_error VARCHAR(250);
BEGIN
    PR_LISTAR_RESERVAS(l_codcliente,pc_error,pm_error);
END;
/