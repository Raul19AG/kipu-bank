## Título de la documentación: Documentación del contrato kipubank

## Introducción
Finalidad del documento: Este documento proporciona información completa sobre el contrato Kipu-bank, sus características, instalación y guía de usuario.

# Alcance del Contrato:
kipubank permite a los usuarios crear una cuenta, almacenar, depositar y extraeer token nativos ETH de una boveda. 

# Destinatarios:
Esta documentación está dirigida a usuarios finales, administradores y desarrolladores.


## Instalación y configuración

# Requisitos previos:
SO windows o Linux, Browsers Explorer, Chrome v.xxx, Firefox V.xxx o posteriores

# Pasos de la descarga:
Instalción a traves de dispositivos extraibles..,
Clona el repositorio: git clone <https://github.com/Raul19AG/kipu-bank>
# Deployed in https://sepolia.etherscan.io/address/0xfc8e0478aaaa73e41e882367b5ff0cf4f9eb9b5b#code

## Guía del usuario

# Cómo empezar:

# Abri tu Navegador favorito, Ingrasa a remix.ethereum.org, desde el Explorador de archivos de remix ingresa a open file from your system y Navega hasta la carpeta del proyecto: contracts, esta carpeta contiene los ficheros:
Kipu-bank.sol
README.md
abrir: Kipu-bank.sol
1.-Compilar con solidity compiler
2.-Click en Deploy and run transactions, en el panel de navegacion que se desplega seleccionar la VM requeriada, scrolear hacia abajo, en deployed contracts
clickear en Kipu-bank AT 0x..., se desplegara los botones deposit, extraccion con un campo de entrada en el cual se ingresa el monto deseado, con el boton getOpe_depo se Visualiza la cantidad de operaciones de deposito realizadas hasta ese momento;
con el boton getOpe_ext se visualiza la cantidad de operaciones de extraccion realizadas hasta ese momento;
el boton s_depositos tiene un campo para ingresar el adress del usuario, con el cual se visualiza EL BALANCE del mismo.

# Como interactuar con el contrato:
Funcion deposit: es la utilizada para Ingresar dinero al la cuenta, emite un evento a la blockchain, incrementa la variable s_oper_depo_total
Funcion extraccion: es para realizar extracciones, recibe un parametro uint256, llama una funcion privada, emite un evento a la blockchain, incrementa la variable s_oper_ext_total.
Funcion getOpe_depo_total: visualiza el registro total de operaciones de DEPOSITO realizadas hasta el momento.
Funcion getOpe_ext_total: visualiza el registro total de operaciones de EXTRACION realizadas hasta el momento.


## Enlace del contrato en el Block chain:
#

## Agradecimientos a:
TalentoTech,ETH*KIPU Sus docentes y compañeros de cusro.
ServiTecPc Incursionando en el Desarrollo de Contratos Inteligentes
Gobierno de la Ciudad.
Ministerio de Educacion de la Ciudad. 
