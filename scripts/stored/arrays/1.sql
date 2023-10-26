DECLARE
    TYPE lt_dias is TABLE OF VARCHAR(10) INDEX BY BINARY_INTEGER;
    l_semana lt_dias;
BEGIN
    l_semana(-10) := 'Lunes';
    l_semana(0) := 'Martes';
    l_semana(10) := 'Miercoles';
    DBMS_OUTPUT.PUT_LINE(l_semana(l_semana.first));
    DBMS_OUTPUT.PUT_LINE(l_semana(l_semana.last));
    IF l_semana.EXISTS(2) THEN
        DBMS_OUTPUT.PUT_LINE('Existe');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No existe');
    END IF;
END;
/