-- -----------------------------------------------------
-- Schema digiwallet
-- -----------------------------------------------------
-- primero debe estar creada la DB y sus tablas
-- segundo haber poblado las tablas antes de realizar las consultas
-- ejecutando los scripts correspondientes
use digiwallet;
-- 
/* Envío y recepción de fondos: Los usuarios deben poder simular un
envió de fondos a otras cuentas dentro de la aplicación y recibir
fondos propios.*/
/* Administración de fondos: Los usuarios deben poder:/* 
/* ver su saldo disponible */
select u.user_name as "usuario", a.account_balance as "saldo disponible" from accounts a 
inner join users u on a.account_user_id = u.user_id where account_user_id = 2; 

/* realizar depósitos */
-- traspaso de fondos entre cuentas del mismo usuario 
insert into transactions values (7, gen_tr_number(), 1, 1, 17770, 17770, '2024-03-11', 'tfr cuentas propias', get_currency_id(1), get_currency_id(2), 1);
-- lista las cuentas del usuario
select a.account_user_id as "usuario", a.account_number as "numero cuenta" 
from accounts a
where a.account_user_id = 1;
-- simula que se definen las cuentas involucradas 
SET @account_number_sender := '000-50-01-257';
SET @account_number_receiver := '01-50-01-00257';
-- se realiza la actualización de fondos
call make_deposit(1, 17770,@account_number_sender,@account_number_receiver);

/* realiazar retiros de fondos.*/
-- se entiende que retiro de fondos es traspasar fondos a un destinatario
insert into transactions values (8, gen_tr_number(), 1, 2, 15550, 15550, '2024-03-11', 'tfr por pago de cuenta luz, gracias', get_currency_id(1), get_currency_id(2), 1);
call update_balance(15550,15550,1,2);

/* Historial de transacciones: Debe haber un registro completo de
todas las transacciones realizadas en la aplicación. */
-- incluye las eliminadas virtualmente
select * from transactions where tr_date between CAST('2024-03-20' as DATE) and CAST('2024-03-31' as DATE);

