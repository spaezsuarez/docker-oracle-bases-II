--Procedimientos: bloques de codigo que no hace retorno
--estandar de nombres
--Variables locales: se antepone una L
--Parametros: se antepone una P

CREATE OR REPLACE PROCEDURE PR_BUSCAR_RESERVA(
    PK_RESERVA IN RESERVA.K_RESERVA%TYPE,
    pn_reserva OUT VARCHAR
)
	IS
    	l_if_reserva RESERVA.F_RESERVA %TYPE;
    	l_valor_reserva RESERVA.V_TOTAL%TYPE;
	BEGIN
        pn_reserva := null;
        lf
    	select F_RESERVA,V_TOTAL INTO l_if_reserva,l_valor_reserva from RESERVA WHERE K_RESERVA = PK_RESERVA;
    	pn_reserva := 'Datos de la reserva '||l_valor_reserva||', Fecha: '||l_if_reserva;
	EXCEPTION WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Reserva no encontrada: '||PK_RESERVA);
END PR_BUSCAR_RESERVA;


--Bloque anonimo del llamado
DECLARE
   LK_RESERVA RESERVA.K_RESERVA%TYPE := 20232;
   LN_RESERVA VARCHAR(100);
BEGIN
   -- Solicitar al usuario los valores
   PR_BUSCAR_RESERVA(LK_RESERVA,LN_RESERVA);
   DBMS_OUTPUT.PUT_LINE(LN_RESERVA);
END;
/
