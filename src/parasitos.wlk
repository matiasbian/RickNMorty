import materiales.*

class Parasito inherits Material {
	var acciones = #{}
	constructor(){
		
	}
	
	constructor(conjAcciones){
		acciones = conjAcciones
	}
	
	method agregarAccion(accion){
		acciones.add(accion)
	}
	
	override method grsDeMetal(){
		return 10
	}
	
	override method electricidadConducible(){
		return 0
	}
	
	override method energiaProducida(){
		return 5
	}
	
	override method esRadioactivo(){
		return false
	}
	
	override method realizoAcciones(rick){
		acciones.forEach({ accion => accion.accionar(rick)})
	}
	
	override method esSerVivo(){
		return true
	}
}

class Accion {
	method accionar(companiero)
}

class EntregarElementos inherits Accion{
	var rick
	constructor (_rick){
		rick = _rick
	}
	override method accionar(companiero){
		companiero.darObjetosA(rick) 
	}
}

class DescartarElemento inherits Accion {
	override method accionar(companiero){
		if (companiero.mochila().size() == 0){
			self.error("Mochila vacia")
		}
		companiero.mochila().remove(companiero.mochila().anyOne())
	}
}

class CambioDeEnergia inherits Accion {
	var energia
	constructor (_energia){
		energia = _energia
	}
	override method accionar(companiero){
		companiero.energia(companiero.energia() + energia)
	}
}

class RecolectarElementoOculto inherits Accion {
	var elementoOculto
	constructor (elemento){
		elementoOculto = elemento
	}
	
	override method accionar(companiero){
		companiero.recolectar(elementoOculto)
	}
}

