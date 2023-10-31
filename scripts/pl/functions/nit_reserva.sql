CREATE OR REPLACE FUNCTION FU_BUSCAR_CLIENTE(
    PK_RESERVA IN RESERVA.K_RESERVA%TYPE
) return NUMBER
IS
    l_cliente RESERVA.K_CODCLIENTE%TYPE;
BEGIN
    select K_CODCLIENTE INTO l_cliente from RESERVA WHERE K_RESERVA = PK_RESERVA;
    RETURN l_cliente;

EXCEPTION WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Cliente no encontrado para reserva: '||PK_RESERVA);
END FU_BUSCAR_CLIENTE;
/


--Bloque anonimo del llamado
DECLARE
   LK_RESERVA RESERVA.K_RESERVA%TYPE := 20232;
BEGIN
   -- Solicitar al usuario los valores
   DBMS_OUTPUT.PUT_LINE('----------------------------');
   DBMS_OUTPUT.PUT_LINE('Cliente: '||FU_BUSCAR_CLIENTE(LK_RESERVA));
   DBMS_OUTPUT.PUT_LINE('----------------------------');
END;
/
