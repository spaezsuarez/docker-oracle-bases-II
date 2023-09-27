DECLARE
   n NUMBER;
   m NUMBER;
   x NUMBER;
   y NUMBER;
   j NUMBER;
BEGIN
   -- Solicitar al usuario los valores
   DBMS_OUTPUT.PUT_LINE('Ingrese la tabla inicial (n): ');
   n := TO_NUMBER(&n);
   DBMS_OUTPUT.PUT_LINE('Ingrese la tabla final (m): ');
   m := TO_NUMBER(&m);
   DBMS_OUTPUT.PUT_LINE('Ingrese el tamaño mínimo de la tabla(x): ');
   x := TO_NUMBER(&x);
   DBMS_OUTPUT.PUT_LINE('Ingrese el tamaño máximo de la tabla(y): ');
   y := TO_NUMBER(&y);

   -- Calcular las tablas de multiplicar
   FOR i IN n..m LOOP
      DBMS_OUTPUT.PUT_LINE('Tabla de multiplicar de ' || i || ':');
         
      -- Usando un bucle FOR
      DBMS_OUTPUT.PUT_LINE('Usando un bucle FOR:');
      FOR j IN x..y LOOP
         DBMS_OUTPUT.PUT_LINE(i || ' x ' || j || ' = ' || (i * j));
      END LOOP;

      -- Usando un bucle WHILE
      DBMS_OUTPUT.PUT_LINE('Usando un bucle WHILE:');
      j := x;
      WHILE j <= y LOOP
         DBMS_OUTPUT.PUT_LINE(i || ' x ' || j || ' = ' || (i * j));
         j := j + 1;
      END LOOP;

      -- Usando un bucle LOOP
      DBMS_OUTPUT.PUT_LINE('Usando un bucle LOOP:');
      j := x;
      LOOP
         EXIT WHEN j > y;
         DBMS_OUTPUT.PUT_LINE(i || ' x ' || j || ' = ' || (i * j));
         j := j + 1;
      END LOOP;

      DBMS_OUTPUT.PUT_LINE('-------------------------');
   END LOOP;
END;
/