CREATE OR REPLACE PROCEDURE PR_LISTAR_RESERVAS(
    pk_codcliente IN CLIENTE.K_CODCLIENTE %TYPE,
    pc_error OUT NUMBER,
    pm_error OUT VARCHAR
)
IS
    CURSOR c_reservas IS SELECT K_RESERVA,F_RESERVA,V_TOTAL FROM RESERVA WHERE K_CODCLIENTE = pk_codcliente;  
    lc_reservas c_reservas%ROWTYPE;
    l_nombrecliente VARCHAR(250);
BEGIN
    pc_error := 0;
    pm_error := '';
    l_nombrecliente := FU_BUSCAR_CLIENTE(pk_codcliente,pc_error,pm_error);
    IF l_nombrecliente IS null THEN
        DBMS_OUTPUT.PUT_LINE(pc_error||' '||pm_error);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cod cliente: '||pk_codcliente);
        DBMS_OUTPUT.PUT_LINE('Nombre Cliente: '||l_nombrecliente);
        DBMS_OUTPUT.PUT_LINE('N Reserva'||'    F Reserva'||'    Vlor total');
        OPEN c_reservas;
        LOOP 
            FETCH c_reservas INTO lc_reservas;
            EXIT WHEN c_reservas%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(lc_reservas.K_RESERVA||'       '||lc_reservas.F_RESERVA||'         '||lc_reservas.V_TOTAL);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Rows: '||c_reservas%ROWCOUNT);
        CLOSE c_reservas;
    END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN
    pc_error := 1;
    pm_error := 'ERROR GENERAL';
END PR_LISTAR_RESERVAS;
/