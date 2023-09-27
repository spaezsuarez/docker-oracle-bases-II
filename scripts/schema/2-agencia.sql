--------------------------------------------------------
-- Archivo creado  - ago 2023
--------------------------------------------------------
connect ALQUILER/pass@XEPDB1;
REM INSERTING into AGENCIA
SET DEFINE OFF;
Insert into AGENCIA (K_AGENCIA,N_NOMBRE) values ('CENTRO','OFICINA CENTRO');
Insert into AGENCIA (K_AGENCIA,N_NOMBRE) values ('SUR','OFICINA SUR');
Insert into AGENCIA (K_AGENCIA,N_NOMBRE) values ('NORTE','OFICINA NORTE');
