//SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

/**
	*@title Contrato kipuBank
	*@notice Este contrato es el tabajo final M2.
	*@author ale
	*@custom:security base .
	*/
contract kipuBank {

	/*///////////////////////
					Variables
	///////////////////////*/
	///@notice variable Inmutable Monto de extraccion maxima
	uint256 immutable i_extMax ;
	///@notice variable Inmutable para almacenar el limite global de deposito
	uint256 immutable i_bankCap;
    ///@notice variable para almacenar el total de operaciones depositos
	uint256 public  s_oper_depo_total;
    ///@notice variable para almacenar el total de operaciones extracciones
	uint256 public s_oper_ext_total;
    	
	///@notice mapping para almacenar el valor dado por el usuário
	mapping(address usuario => uint256 valor) public s_depositos;
	
	/*///////////////////////
						Events
	////////////////////////*/
	///@notice evento emitido cuando un nuevo deposito es hecho
	event kipubank_Deposito(address depositante, uint256 valor);
	///@notice evento emitido cuando una extraccion es hecha
	event kipubank_ExtraccionHecha(address receptor, uint256 valor);
	
	/*///////////////////////
						Errors
	///////////////////////*/
	///@notice error emitido cuando la transaccion falla
	error kipubank_TransaccionFallo(bytes error);
	///@notice error emitido cuando la direccion es diferente a la del beneficiario 
	error kipubank_ClienteNoValido(address extraccionista, address usuario);
	///@notice error emitido cuando el saldo es Insuficiente
	error KipubanK_BalanceInsuficiente();
	///@notice error emitido cuando el monto es mayor a i_extMax
	error KipubanK_MontoMaxExcedido();
	///@notice error monto invalido
	error KipubanK_MontoInvalido(string);
	/*//////////////////////
					Modifiers
    //////////////////////*/
	///@notice modificador para validar el beneficiario
	modifier MontoInvalido() {
		if(msg.value > i_bankCap || msg.value <= 0){
			revert KipubanK_MontoInvalido("Monto Invalido");
		}
		_;
	}
					
	
	/*///////////////////////
					Functions
	///////////////////////*/
	constructor(uint256 _limite){
		//i_beneficiario = msg.sender;
		i_bankCap = _limite;
		i_extMax = 10*10**18;
		

	}
		
	/**
		*@notice funcion para realizar depositos
		*@dev esta funcion debe sumar el valor depositado a s_depositos
		*@dev esta funcion precisas emitir el evento KipubanK_Deposito.
	*/
	function deposit() external payable MontoInvalido{
                    emit kipubank_Deposito(msg.sender, msg.value);
		    		s_depositos[msg.sender] = s_depositos[msg.sender] + msg.value;
					if(getMyBalance()>=i_bankCap) revert KipubanK_MontoInvalido("Capacidad Maxima del Banco");
				
		unchecked{
		++s_oper_depo_total;
		}
	}
	
	/*
		*@notice funcion para realizar Extracciones
		*@notice El _monto de la extraccion debe ser <= a mi balance
		*@dev solo el titualr de la cuenta puede realizar la extraccion
		*@param _monto valor a ser extraido
	*/
	function extraccion(uint256 _monto) external {
		if(_monto > i_extMax) revert  KipubanK_MontoMaxExcedido();
		if(_monto > s_depositos[msg.sender]) revert KipubanK_MontoInvalido("saldo Insuficiente");
		_transferirEth(_monto);
        emit kipubank_ExtraccionHecha(msg.sender, _monto);
		s_depositos[msg.sender] = s_depositos[msg.sender] - _monto;
		unchecked{
		++s_oper_ext_total;
		}
	}
	
	/*
		*@notice funcion privada para realizar  transferência de ether
		*@param _monto valor a ser transferido
		*@dev precisa revert si falla
	*/
	function _transferirEth(uint256 _monto) private {
		(bool sucess, bytes memory error) = msg.sender.call{value: _monto}("");
		if(!sucess) revert kipubank_TransaccionFallo(error);
	}
    /*
		*@notice funcion privada para obtener el balance del contrato actual
		*@retorna el balance del contrato
		*/
   function getMyBalance() private returns (uint256) {
        return address(this).balance;
    }
}
