DECLARE
    --Declaracion de variables
    tabla1 NUMBER(10,0) := &tablainicial;
    tabla2 NUMBER(10,0) := &tablafinal;
    multiplicador1 NUMBER(10,0) := &multiplicadorinicial;
    multiplicador2 NUMBER(10,0) := &multiplicadorfinal;
    opcion varchar(1) := &ciclo;
    iteradorAux NUMBER(10,0) := multiplicador1;
BEGIN
    IF opcion = 'F' THEN
        FOR i IN tabla1..tabla2
        LOOP
            FOR j IN multiplicador1..multiplicador2
            LOOP
                DBMS_OUTPUT.PUT_LINE(i ||'x'||j||'='||i*j);
            END LOOP;
        END LOOP;
    ELSIF opcion = 'W' THEN
        WHILE tabla1 <= tabla2 LOOP
            WHILE iteradorAux <= multiplicador2 LOOP
                DBMS_OUTPUT.PUT_LINE(tabla1 ||'x'|| iteradorAux || ' = ' || (tabla1 * iteradorAux));
                iteradorAux := iteradorAux + 1;
            END LOOP;
            iteradorAux := multiplicador1;
            tabla1 := tabla1 + 1;
        END LOOP;
    ELSIF opcion = 'L' THEN
        LOOP
        EXIT WHEN tabla1 > tabla2;
            LOOP
            EXIT WHEN iteradorAux > multiplicador2;
                DBMS_OUTPUT.PUT_LINE(tabla1 ||'x'|| iteradorAux || ' = ' || (tabla1 * iteradorAux));
                iteradorAux := iteradorAux + 1;
            END LOOP;
            iteradorAux := multiplicador1;
            tabla1 := tabla1 + 1;
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingrese un ciclo valido');
    END IF;
END;
/