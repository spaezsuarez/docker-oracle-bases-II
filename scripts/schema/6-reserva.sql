--------------------------------------------------------
-- Archivo creado  - ago  2023
--------------------------------------------------------
connect ALQUILER/pass@XEPDB1;
REM INSERTING into RESERVA
SET DEFINE OFF;
Insert into RESERVA (K_RESERVA,F_RESERVA,F_INICIAL,F_FINAL,V_TOTAL,I_ESTADO,K_AGENCIA,K_CODCLIENTE) values ('20231',to_date('19/08/23','DD/MM/RR'),to_date('20/08/23','DD/MM/RR'),to_date('22/08/23','DD/MM/RR'),'690000','PAG','CENTRO','101');
Insert into RESERVA (K_RESERVA,F_RESERVA,F_INICIAL,F_FINAL,V_TOTAL,I_ESTADO,K_AGENCIA,K_CODCLIENTE) values ('20232',to_date('19/08/23','DD/MM/RR'),to_date('20/08/23','DD/MM/RR'),to_date('21/08/23','DD/MM/RR'),'260000','PEN','SUR','102');
Insert into RESERVA (K_RESERVA,F_RESERVA,F_INICIAL,F_FINAL,V_TOTAL,I_ESTADO,K_AGENCIA,K_CODCLIENTE) values ('20233',to_date('19/08/23','DD/MM/RR'),to_date('19/08/23','DD/MM/RR'),to_date('23/08/23','DD/MM/RR'),'800000','ACT','CENTRO','103');
Insert into RESERVA (K_RESERVA,F_RESERVA,F_INICIAL,F_FINAL,V_TOTAL,I_ESTADO,K_AGENCIA,K_CODCLIENTE) values ('20234',to_date('18/08/23','DD/MM/RR'),to_date('22/08/23','DD/MM/RR'),to_date('25/08/23','DD/MM/RR'),'520000','PAG','NORTE','106');
Insert into RESERVA (K_RESERVA,F_RESERVA,F_INICIAL,F_FINAL,V_TOTAL,I_ESTADO,K_AGENCIA,K_CODCLIENTE) values ('20235',to_date('17/08/23','DD/MM/RR'),to_date('19/08/23','DD/MM/RR'),to_date('30/08/23','DD/MM/RR'),'4560000','ACT','SUR','105');
