-- -----------------------------------------------------
-- Schema digiwallet
-- -----------------------------------------------------
/* Crear consultas SQL para: */
USE digiwallet;

/* - Consulta para obtener el nombre de la moneda elegida por un
usuario específico */
SET @id_currency = 1;    
SELECT currency_name FROM currencies WHERE currency_id IN (
SELECT account_currency_id FROM accounts INNER JOIN users
ON account_user_id = user_id WHERE user_id = @id_currency
);

/* - Consulta para obtener todas las transacciones registradas */
-- muestra transacciones activas (excluye eliminadas virtualmente)
SELECT * FROM transactions WHERE tr_state = 1;

-- en periodo determinado pero excluyendo las eliminadas virtualmente
SELECT * FROM transactions WHERE tr_state = 1 AND tr_date IN 
(SELECT tr_date FROM transactions WHERE tr_date 
BETWEEN CAST('2024-03-20' as DATE) AND CAST('2024-03-31' as DATE));
/* - Consulta para obtener todas las transacciones realizadas por un usuario específico */
-- muestra transacciones activas de un usuario

SELECT * FROM transactions t WHERE t.tr_sender_user_account_id IN (
SELECT u.user_id 
FROM users u INNER JOIN accounts a ON u.user_id = a.account_user_id
WHERE u.user_id = 1)  
AND t.tr_state = 1;
/* - Sentencia DML para modificar el campo correo electrónico de un usuario específico */
UPDATE users SET user_email = 'mariacardenas@gmail.com' WHERE user_id = 2;

/* - Sentencia para eliminar los datos de una transacción (eliminado de la fila completa) 
observacion: no se elimina fila, se desactiva cambiANDo su estado a falso (0)
*/
-- primero recuperar datos de la transaccion para ser revertida la operación
-- empleando variables
-- la transaccion sera la número 4
-- realizando los cambios necesarios para realizar eliminación virtual
-- no utilisaría ----->   DELETE FROM transactions WHERE tr_id = 4;
-- sino que desactiva transacción, eliminación virtual
UPDATE transactions SET tr_state = 0 WHERE tr_id = 4;
SELECT @amount_s := ROUND(tr_amount_sender,2), 
	   @amount_r := round(tr_amount_receiver,2), 
       @sender_account := tr_sender_user_account_id, 
       @receiver_account := tr_receiver_user_account_id 
	FROM transactions WHERE tr_id = 4;

-- a modo de información se visualiza los datos antes de reversar saldos
SELECT account_number, account_balance 
FROM accounts 
WHERE account_id = @sender_account OR account_user_id = @receiver_account;
-- entonces reversa los montos en las cuentas involucradas en la transacción
CALL restore_balance(@amount_s, @amount_r, @sender_account, @receiver_account);
-- a modo de información visualiza desactivación de transacción
SELECT tr_state FROM transactions WHERE tr_id = 4;
-- a modo de información visualiza actualizacion de saldos
SELECT account_number, account_balance 
FROM accounts 
WHERE account_id = @sender_account OR account_id=@receiver_account;
