USE `digiwallet` ;
/* poblando user */

insert into users values 
(1,'ferando','diaz', 'fena', '10000000-8', 'fdias@gmail.com', 'abc123', '2024-04-11', 35, 1, 1, 1, 1);
insert into users values 
(2,'maria','cardenas', 'maria', '10000001-6', 'mcardenas@gmail.com', 'abc123', '2024-04-12', 25, 0, 0, 1, 1);

/* poblando bank */
insert into banks values (1,'banco estado', 1);
insert into banks values (2,'banco de chile', 1);
insert into banks values (3,'banco b.c.i.', 1);

/* poblando currencies */
insert into currencies values (1,'peso chileno', 'CLP', 1);
insert into currencies values (2,'euro', 'EUR', 1);
insert into currencies values (3,'dolar estadounidense', 'USD', 1);

/* poblando types_of_accounts */
insert into types_of_accounts values (1, 'cuenta rut', 1);
insert into types_of_accounts values (2, 'chequera electronica', 1);
insert into types_of_accounts values (3, 'cuenta corriente', 1);
insert into types_of_accounts values (4, 'cuenta de ahorro', 1);

/* poblando accounts */
insert into accounts values (1, 1, '000-50-01-257', 1000000, 1, '2023-10-31', 1, 1, 1);
insert into accounts values (2, 2, '000-10-03-598', 1000000, 1, '2023-12-31', 2, 1, 1);

/* poblando cities */
insert into cities values (1, 'santiago');
insert into cities values (2, 'rancagua');
insert into cities values (3, 'valparaiso');

/* poblando countries */
insert into countries values (1, 'chile');
insert into countries values (2, 'argentina');
insert into countries values (3, 'mexico');

/* poblando address */
insert into address values (1, 'pasaje ines 245', 1, 1, '+569 256 7880');
insert into address values (2, 'monseñor joel rios 1.356', 2, 1, '+569 556 8220');

/* poblando transactions */
delete from transactions where tr_id > 0;
-- tipos de inserciones
-- generando tr_number 
-- para generar number transaction
-- set @tr_number := (SELECT reverse(replace(RAND(),'.','')));
-- insert into transactions values (6, @tr_number, 2, 1, 450000, '2024-03-21', 'cuota 5/8 auto, gracias', 1, 1);
-- insert into transactions values (7, (SELECT reverse(replace(RAND(),'.',''))), 2, 1, 450000, '2024-03-21', 'cuota 5/8 auto, gracias', 1, 1);
-- select @tr_number;
-- convierte number a char 
-- set @trnumber := (select convert(@tr_number, char));
-- insert into transactions values (2, @trnumber, 1, 2, 25800, '2024-03-11', 'tfr por pago de cuenta luz, gracias', 1, 1);

-- quitar modo estructo para crear o utilizar función
set global log_bin_trust_function_creators=1;
-- crypto.randomUUID() -- largo 36 caracteres
-- creación funcion para generar número de transacción aleatorio
delimiter ||
CREATE DEFINER=`root`@`localhost` FUNCTION `gen_tr_number`() 
RETURNS varchar(20)
BEGIN
    
RETURN (SELECT (replace(RAND(),'.','')));
END;
||
-- fin function gen_tr_number
-- creación función para recuperar id moneda 
delimiter ||
CREATE DEFINER=`root`@`localhost` FUNCTION `get_currency_id`(id INTEGER) 
RETURNS INTEGER
BEGIN
    
RETURN (SELECT account_currency_id FROM accounts INNER JOIN users
		ON account_user_id = user_id where user_id = id limit 1);
END;
||
-- fin function gen_tr_number
-- probando functiones
-- select gen_tr_number();
-- select get_currency_id(1);
--
-- empleando funcion para generar numero de transaccion
insert into transactions values (1, gen_tr_number(), 1, 2, 15000, 15000,'2024-03-10', 'devolucion dinero, gracias', get_currency_id(1), get_currency_id(2), 1);
insert into transactions values (2, gen_tr_number(), 1, 2, 25800, 25800, '2024-03-11', 'tfr por pago de cuenta luz, gracias', get_currency_id(1), get_currency_id(2), 1);
insert into transactions values (3, gen_tr_number(), 2, 1, 75000, 75000, '2024-03-12', 'prestamo dinero acordado', get_currency_id(1), get_currency_id(2), 1);
insert into transactions values (4, gen_tr_number(), 1, 2, 151000, 151000, '2024-03-20', 'adelanto devolucion dinero, gracias', get_currency_id(1), get_currency_id(2), 1);
insert into transactions values (5, gen_tr_number(), 2, 1, 45000, 45000, '2024-03-21', 'cuota 5/8 auto, gracias', get_currency_id(1), get_currency_id(2), 1);
insert into transactions values (6, gen_tr_number(), 2, 1, 66000, 66000, '2024-03-21', 'ajuste cuota auto, gracias', get_currency_id(1), get_currency_id(2), 1);

/* poblando contacts */
insert into contacs values (1, 1, 2, 1);
insert into contacs values (2, 2, 1, 1);

/* poblando users_address */
insert into users_address values (1, 1, 1, 1);
insert into users_address values (2, 2, 2, 1);
