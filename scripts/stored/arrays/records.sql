DECLARE
    TYPE lt_paises is RECORD (
        ln_pais varchar(15),
        ln_capital varchar(15)
    );
    TYPE lt_countries is TABLE OF lt_paises INDEX BY BINARY_INTEGER;
    l_paisCapital lt_countries;
BEGIN
    l_paisCapital(0).ln_pais := 'Colombia';
    l_paisCapital(0).ln_capital := 'Bogota';
END;
/