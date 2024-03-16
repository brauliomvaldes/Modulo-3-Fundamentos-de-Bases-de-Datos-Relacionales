Script de creación base de datos DigiWallet

Consiste en la creación de las tablas base para operar con la billetera electrónica, estas son:

- Users
- Accounts
- Currencies
- Transactions
- Banks

También contiene los scripts para poblar las tablas y para realizar las consultas requeridas por la evaluación del módulo.
El modelo planteado considera la posibilidad de transferir dinero entre cuentas, inclusive con distintos tipos de divisas, lo que se logra mediante el correspondiente cálculo de conversión monetaria.
Para esto se registra el origen y destino de las cuentas y también de ambos montos involucrados.
* Sobre el registro de transferencias:
El objetivo de los campos que registran el movimiento, es poder realizar eliminación de transacciones proceso que requiere reversar los findos involucrados a sus valores originales sin requerir realizar cálculos adicionales. Así, en caso de ransferencias con distintas divisas, los montos involucrados se reasignaran a sus cuentas de origen, por ejemplo, si 10.000 pesos chilenos de conviertieron a $ 100 dólares americanos, se rebajaran o abonaran dependiendo del caso, los respectivos montos de las cuentas incolucradas y en el caso de reliazar una eliminación, se revertirá esta operación y se reintegraran los montos originales a sus correspondientes cuentas sin realizar càlculos adicionales.
Esta billetera electrónica no considera ningún tipo de reajuste.