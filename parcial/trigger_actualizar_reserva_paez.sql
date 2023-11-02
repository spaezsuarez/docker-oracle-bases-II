/*------------------------------------------------------------------------------
     Trigger
*/
CREATE OR REPLACE TRIGGER TG_ACTUALIZAR_RESERVA_PAEZ
BEFORE UPDATE OF V_ALQUILER ON VEHICULO_RESERVA
FOR EACH ROW
DECLARE
    lc_reserva RESERVA%ROWTYPE;
    li_valor RESERVA.V_TOTAL%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ejecute trigger vehiculo_reserva');
    SELECT * into lc_reserva FROM RESERVA where K_RESERVA = :old.K_RESERVA;
    DBMS_OUTPUT.PUT_LINE('RESERVA: '|| lc_reserva.K_RESERVA);
    DBMS_OUTPUT.PUT_LINE('Valor antiguo '||lc_reserva.V_TOTAL);
    li_valor := lc_reserva.V_TOTAL - :old.V_ALQUILER + :new.V_ALQUILER;
    DBMS_OUTPUT.PUT_LINE('Valor NUevo '||li_valor);
    UPDATE RESERVA SET V_TOTAL = li_valor WHERE K_RESERVA=:old.K_RESERVA;
EXCEPTION WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Reserva inexistente');
END TG_ACTUALIZAR_RESERVA_PAEZ;
/