CREATE OR REPLACE TRIGGER TG_CLIENTE
BEFORE UPDATE OR INSERT OF N_NOMBRE1,N_APELLIDO1 ON CLIENTE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ejecute trigger');
    IF UPDATING THEN
        IF :old.N_NOMBRE1 <> :new.N_NOMBRE1 THEN
            DBMS_OUTPUT.PUT_LINE('Actualziando nombre ');
            :new.N_NOMBRE1 := UPPER(:new.N_NOMBRE1);
        END IF;

        IF :old.N_APELLIDO1 <> :new.N_APELLIDO1 THEN
            DBMS_OUTPUT.PUT_LINE('Actualziando apellido ');
            :new.N_APELLIDO1 := UPPER(:new.N_APELLIDO1);
        END IF;
    ELSE
        :new.N_NOMBRE1 := UPPER(:new.N_NOMBRE1);
        :new.N_APELLIDO1 := UPPER(:new.N_APELLIDO1);
    END IF;

END TG_CLIENTE;
/