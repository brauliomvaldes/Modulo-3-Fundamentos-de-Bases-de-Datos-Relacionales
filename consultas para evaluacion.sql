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
-- alternativa con variables 
-- recuperar datos de la transaccion para ser revertida la operación
-- set @amount := (select tr_amount from transactions where tr_id = 4);
-- set @sender := (select tr_sender_user_id from transactions where tr_id = 4);
-- set @receiver := (select tr_receiver_user_id from transactions where tr_id = 4);
-- alternativa menos código
select @amount_s := tr_amount_sender, @amount_r := tr_amount_receiver, @sender := tr_sender_user_id, @receiver := tr_receiver_user_id 
				from transactions where tr_id = 4;
-- realiza los cambios 
-- desactiva transacción
update transactions set tr_state = 0 where tr_id = 4;
-- reversa los montos en las cuentas involucradas en la transacción
update accounts set account_balance = account_balance + @amount_s where account_user_id = @sender;
update accounts set account_balance = account_balance - @amount_r where account_user_id = @receiver;
-- confirma desactivación de transacción
select tr_state from transactions where tr_id = 4;
-- confirma actualizacion de saldos
select account_user_id, account_balance from accounts where account_user_id = 1 or account_user_id=2;