DECLARE
    --Declaracion de variables
    a int := &numero1;
    factorial int;
BEGIN
    IF a = 0 THEN
        factorial := 1;
    ELSE
        FOR I IN (a..1)
    END IF;
    DBMS_OUTPUT.PUT_LINE('El factorial de: '|| a || ' es: '||factorial);
END;
/