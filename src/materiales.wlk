
class Material {
	var grsDeMetal
	var electricidadConducible
	var electricidadGenerable
	var esRadioactivo
	var energiaProducida

	method grsDeMetal()
	
	method grsDeMetal(cantidad){
		grsDeMetal = cantidad
	}
	
	method electricidadConducible()
	
	method electricidadConducible(cantidad){
		electricidadConducible = cantidad
	}
	
	method electricidadGenerable()
	
	method electricidadGenerable(cantidad){
		electricidadGenerable = cantidad
	}
	
	method esRadioactivo ()
	
	method esRadioactivo(booleano){
		esRadioactivo = booleano
	}
	
	method energiaProducida()
	
	method energiaProducida(cantidad){
		energiaProducida = cantidad
	}
	
	

}

class Lata inherits Material {
	
	constructor (_grsDeMetal){
		grsDeMetal = _grsDeMetal
	}
	
	override method grsDeMetal(){
		return grsDeMetal
	}
	
	override method electricidadConducible(){
		return 0.1 * grsDeMetal
	}
	
	override method energiaProducida(){
		return 0
	}
	
	override method electricidadGenerable(){
		0
	}
	
}

class Cable inherits Material {
	var longitud
	var seccion 
	constructor (_longitud,_seccion){
		longitud = _longitud
		seccion = _seccion
	}
	
	override method grsDeMetal(){
		return (longitud /1000) * seccion
	}
	
	override method electricidadConducible(){
		return 3 * seccion
	}
	
	override method energiaProducida(){
		return 0
	}
	
	override method electricidadGenerable(){
		return 0
	}
}



