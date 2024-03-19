-- -----------------------------------------------------
-- Schema digiwallet
-- -----------------------------------------------------
USE `digiwallet` ;
/* poblando user */

INSERT INTO users VALUES 
(1,'ferando','diaz', 'fena', '10000000-8', 'fdias@gmail.com', 'abc123', '2024-04-11', 35, 1, 1, 1, 1);
INSERT INTO users VALUES 
(2,'maria','cardenas', 'maria', '10000001-6', 'mcardenas@gmail.com', 'abc123', '2024-04-12', 25, 0, 0, 1, 1);

/* poblando bank */
INSERT INTO banks VALUES (1,'banco estado', 1);
INSERT INTO banks VALUES (2,'banco de chile', 1);
INSERT INTO banks VALUES (3,'banco b.c.i.', 1);

/* poblando currencies */
INSERT INTO currencies VALUES (1,'peso chileno', 'CLP', 1);
INSERT INTO currencies VALUES (2,'euro', 'EUR', 1);
INSERT INTO currencies VALUES (3,'dolar estadounidense', 'USD', 1);

/* poblando types_of_accounts */
INSERT INTO types_of_accounts VALUES (1, 'cuenta rut', 1);
INSERT INTO types_of_accounts VALUES (2, 'chequera electronica', 1);
INSERT INTO types_of_accounts VALUES (3, 'cuenta corriente', 1);
INSERT INTO types_of_accounts VALUES (4, 'cuenta de ahorro', 1);

/* poblando accounts */
INSERT INTO accounts VALUES (1, 1, '000-50-01-257', 1000000.00, 1, '2023-10-31', 1, 1, 1);
INSERT INTO accounts VALUES (2, 2, '000-10-03-598', 1000000.00, 1, '2023-12-31', 2, 1, 1);
INSERT INTO accounts VALUES (3, 1, '01-50-01-00257', 1000000.00, 1, '2023-12-28', 1, 2, 1);

/* poblando cities */
INSERT INTO cities VALUES (1, 'santiago');
INSERT INTO cities VALUES (2, 'rancagua');
INSERT INTO cities VALUES (3, 'valparaiso');

/* poblando countries */
INSERT INTO countries VALUES (1, 'chile');
INSERT INTO countries VALUES (2, 'argentina');
INSERT INTO countries VALUES (3, 'mexico');

/* poblando address */
INSERT INTO address VALUES (1, 'pasaje ines 245', 1, 1, '+569 256 7880');
INSERT INTO address VALUES (2, 'monseñor joel rios 1.356', 2, 1, '+569 556 8220');


-- poblando tabla transacciones entre distintos usuario
-- se emplea una funcion para generar numero de transaccion
INSERT INTO transactions VALUES (1, gen_tr_number(), 1, 2, 15000, 15000,'2024-03-10', 'devolucion dinero, gracias', get_currency_id(1), get_currency_id(2), 1);
-- empleando procedimiento para actualiza los saldos en las cuentas involucradas en la transacción
CALL update_balance(15000,15000,1,2);
INSERT INTO transactions VALUES (2, gen_tr_number(), 1, 2, 25800, 25800, '2024-03-11', 'tfr por pago de cuenta luz, gracias', get_currency_id(1), get_currency_id(2), 1);
CALL update_balance(25800,25800,1,2);
INSERT INTO transactions VALUES (3, gen_tr_number(), 2, 1, 75000, 75000, '2024-03-12', 'prestamo dinero acordado', get_currency_id(1), get_currency_id(2), 1);
CALL update_balance(75000,75000,1,2);
INSERT INTO transactions VALUES (4, gen_tr_number(), 1, 2, 151000, 151000, '2024-03-20', 'adelanto devolucion dinero, gracias', get_currency_id(1), get_currency_id(2), 1);
CALL update_balance(151000,151000,1,2);
INSERT INTO transactions VALUES (5, gen_tr_number(), 2, 1, 45000, 45000, '2024-03-21', 'cuota 5/8 auto, gracias', get_currency_id(1), get_currency_id(2), 1);
CALL update_balance(45000,45000,1,2);
INSERT INTO transactions VALUES (6, gen_tr_number(), 2, 1, 66000, 66000, '2024-03-21', 'ajuste cuota auto, gracias', get_currency_id(1), get_currency_id(2), 1);
CALL update_balance(66000,66000,1,2);

/* poblando contacts */
INSERT INTO contacs VALUES (1, 1, 2, 1);
INSERT INTO contacs VALUES (2, 2, 1, 1);

/* poblando users_address */
INSERT INTO users_address VALUES (1, 1, 1, 1);
INSERT INTO users_address VALUES (2, 2, 2, 1);
