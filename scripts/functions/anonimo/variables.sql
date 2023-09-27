DECLARE
    --Declaracion de variables
    a NUMBER(10,0) := &numero1;
    b NUMBER(10,0) := &numero2;
    c NUMBER(10,0) := &numero3;
    menor NUMBER(10,0);
BEGIN
    IF a < b THEN
        menor := a;
    ELSE
        menor := b;
    END IF;
    IF c < menor THEN
        menor := c;
    END IF;
    DBMS_OUTPUT.PUT_LINE('El menor es: '||menor);
END;
/