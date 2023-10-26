CREATE OR REPLACE FUNCTION FU_BUSCAR_CLIENTE(
    pk_codcliente IN CLIENTE.K_CODCLIENTE %TYPE,
    pc_error OUT NUMBER,
    pm_error OUT VARCHAR
) return VARCHAR
IS
    l_nombrecliente VARCHAR(250) := '';
BEGIN
    pc_error := 0;
    pm_error := '';
    select N_NOMBRE1 ||' '||N_NOMBRE2 || ' ' || N_APELLIDO1 ||' '||N_APELLIDO2  INTO l_nombrecliente FROM CLIENTE C WHERE K_CODCLIENTE = pk_codcliente;
    RETURN l_nombrecliente;

EXCEPTION WHEN NO_DATA_FOUND THEN
    pc_error := 1;
    pm_error := 'Cliente no encontrado: '||pk_codcliente;
    RETURN NULL;
END FU_BUSCAR_CLIENTE;
/