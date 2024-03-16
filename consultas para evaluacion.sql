-- -----------------------------------------------------
-- Schema digiwallet
-- -----------------------------------------------------
/* Crear consultas SQL para: */
use digiwallet;

/* - Consulta para obtener el nombre de la moneda elegida por un
usuario específico */
select currency_name from currencies where currency_id in (
select account_currency_id from accounts inner join users
on account_user_id = user_id where user_id = 1
);

/* - Consulta para obtener todas las transacciones registradas */
-- muestra transacciones activas
select * from transactions where tr_state = 1;

/* - Consulta para obtener todas las transacciones realizadas por un usuario específico */
-- muestra transacciones activas de un usuario
select * from transactions where tr_sender_user_id = 1 and tr_state = 1;

/* - Sentencia DML para modificar el campo correo electrónico de un usuario específico */
update users set user_email = 'mariacardenas@gmail.com' where user_id = 2;

/* - Sentencia para eliminar los datos de una transacción (eliminado de la fila completa) 
observacion: no se elimina fila, se desactiva cambiando su estado a falso (0)
*/
-- recuperar datos de la transaccion para ser revertida la operación
-- empleando variables
select @amount_s := ROUND(tr_amount_sender,2), @amount_r := round(tr_amount_receiver,2), @sender := tr_sender_user_id, @receiver := tr_receiver_user_id 
				from transactions where tr_id = 4;
-- realizando los cambios necesarios para realizar eliminación virtual
-- desactiva transacción, eliminación virtual
update transactions set tr_state = 0 where tr_id = 4;
-- visualiza actualizacion antes de reversar saldos
select account_user_id, account_balance from accounts where account_user_id = 1 or account_user_id=2;
-- reversa los montos en las cuentas involucradas en la transacción
call restore_balance(@amount_s, @amount_r, @sender, @receiver);
-- confirma desactivación de transacción
select tr_state from transactions where tr_id = 4;
-- visualiza actualizacion de saldos
select account_user_id, account_balance from accounts where account_user_id = 1 or account_user_id=2;