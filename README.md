* DigiWallet 

Script de creación base de datos DigiWallet

Consiste en la creación de las tablas base para operar con la billetera electrónica, estas son:

- Users
- Accounts
- Currencies
- Banks
- Transactions


También contiene los scripts para poblar las tablas y para realizar las consultas requeridas por la evaluación del módulo.
El modelo planteado considera la posibilidad de transferir dinero entre cuentas, inclusive con distintos tipos de divisas, lo que se logra mediante el correspondiente cálculo de conversión monetaria.
Para esto se registra el origen y destino de las cuentas y también de ambos montos involucrados.

** Sobre el registro de transferencias:

El objetivo de los campos que registran el movimiento, es poder realizar eliminación de transacciones, proceso que requiere actualizar los fondos al reversar los montos involucrados, utilizando los valores originales sin requerir realizar cálculos adicionales. Así, en caso de transferencias con distintas divisas, los montos involucrados se reasignaran a sus cuentas de origen dependiendo del caso si es abono o cargo, por ejemplo, si 10.000 pesos chilenos de conviertieron a $ 100 dólares americanos, si se realiza una eliminación "virtual", se invertirá la operación, empleando los montos almacenados sin realizar ningún cálculos adicionales.

** Sobre la eliminación virtual: 

Consiste en el cambio de estado del registro que almacena la transferenbcia, pasnado del estado activo (1) a desactivado(0), con esto se consigue presenvar la información para futuros procesos.

Esta billetera electrónica no considera ningún tipo de reajuste.