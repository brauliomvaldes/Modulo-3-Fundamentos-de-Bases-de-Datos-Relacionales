-- -----------------------------------------------------
-- Schema digiwallet
-- -----------------------------------------------------
-- primero debe estar creada la DB y sus tablas
-- segundo haber poblado las tablas antes de realizar las consultas
-- ejecutando los scripts correspondientes
USE digiwallet;
-- 
/* Envío y recepción de fondos: Los usuarios deben poder simular un
envió de fondos a otras cuentas dentro de la aplicación y recibir
fondos propios.*/
/* Administración de fondos: Los usuarios deben poder:/* 
/* ver su saldo disponible */
-- en este caso, el usuario = 2
SELECT u.user_name AS "usuario", a.account_balance AS "saldo disponible" FROM accounts a 
INNER JOIN users u on a.account_user_id = u.user_id WHERE account_user_id = 2; 

/* realizar depósitos */
-- en este caso se realiza traspaso de fondos entre cuentas del mismo usuario 
-- primero confirmar que el usuario tenga más de una cuenta
-- busqueda de las cuentas del usuario  almacenando las cuenta en una tabla temporal
-- antes elimina la tabla temporal si existiera
DROP TABLE IF EXISTS temporary_account_user;
-- crea una tabla temporal para listar las cuentas del usuario
CREATE TEMPORARY TABLE temporary_account_user
SELECT a.account_id AS "ID cuenta", a.account_number AS "numero cuenta", a.account_balance AS "saldo"
FROM accounts a
WHERE a.account_user_id = 1;
-- lista cuentas
SELECT * FROM temporary_account_user;
-- sólo si hay más de una cuenta sigue proceso 
-- se envian al frontend para para selección y validación de saldos,
-- simula la selección de las cuentas involucradas para verificar los saldos
-- se recuperan esos datos seleccionados y estos podrían ser los siguientes
-- ID de la cuenta del sender
SET @account_id_sender := 1;
-- ID de la cuenta del receiver
SET @account_id_receiver := 3;
-- seleccionar cuentas con saldos para relizar la operación
-- sólo si hay saldo disponible en cuenta SENDER se puede realizar la operación
INSERT INTO transactions VALUES (7, gen_tr_number(), 1, 1, 17770, 17770, '2024-03-11', 'tfr cuentas propias', get_currency_id(1), get_currency_id(2), 1);
-- se realiza la actualización de fondos, enviando el monto y los ID de las cuentas
CALL make_deposit(17770,@account_id_sender,@account_id_receiver);
/* realiazar retiros de fondos.*/
-- se entiende que retiro de fondos es traspasar fondos a un destinatario
INSERT INTO transactions VALUES (8, gen_tr_number(), 1, 2, 15550, 15550, '2024-03-11', 'tfr por pago de cuenta luz, graciAS', get_currency_id(1), get_currency_id(2), 1);
CALL update_balance(15550,15550,1,2);

/* Historial de transacciones: Debe haber un registro completo de
todAS las transacciones realizadas en la aplicación. */
-- incluye las eliminadas virtualmente
SELECT * FROM transactions WHERE tr_date BETWEEN CAST('2024-03-20' AS DATE) AND CAST('2024-03-31' AS DATE);

