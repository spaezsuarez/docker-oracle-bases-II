DECLARE
   lc_clientes SYS_REFCURSOR;
   lk_codcliente CLIENTE.K_CODCLIENTE%TYPE;
   ln_apellido1 CLIENTE.N_APELLIDO1%TYPE;
BEGIN
   PR_LISTAR_CLIENTES(lc_clientes);
   LOOP 
      FETCH lc_clientes INTO lk_codcliente,ln_apellido1;
         EXIT WHEN lc_clientes%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE(lk_codcliente||'       '||ln_apellido1||'         ');
   END LOOP;
   CLOSE lc_clientes;
END;
/