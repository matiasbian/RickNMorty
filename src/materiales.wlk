
class Material {
	var grsDeMetal
	var electricidadConducible
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
	
	
	method esRadioactivo ()
	
	method esRadioactivo(booleano){
		esRadioactivo = booleano
	}
	
	method energiaProducida()
	
	method energiaProducida(cantidad){
		energiaProducida = cantidad
	}
	method descuentoPorRecolectar(){
		return self.grsDeMetal()
	}
	method aportePorRecolectar(){
		return self.energiaProducida()
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
	
	override method esRadioactivo(){
		return false
	}
	
	override method energiaProducida(){
		return 0
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
	
	override method esRadioactivo(){
		return false
	}
	
}



class Fleeb inherits Material{
	const matComida =  #{}
	var edad
	
	constructor(_edad){
		edad = _edad
	}
	method comer(unaComida){
		matComida.add(unaComida)
	}
	override method electricidadConducible(){
		if (matComida.size() == 0){
			return 0
		}
		return matComida.min({material => material.electricidadConducible()}).electricidadConducible()
	}
	override method esRadioactivo(){
		return edad > 15 
	}
	override method grsDeMetal(){
		return matComida.sum {material => material.grsDeMetal()} 	
	}
	override method energiaProducida(){
		if (matComida.size() == 0){
			return 0
		}
		return matComida.max({material => material.electricidadConducible()}).electricidadConducible()
	}
	override method descuentoPorRecolectar(){
		return super() * 2
	}
	override method aportePorRecolectar(){
		return if(! self.esRadioactivo()) 10 else 0
	}
}

class MateriaOscura inherits Material{
	const materialBase
	
	constructor(_materialBase){
		materialBase = _materialBase
	}
	
	override method electricidadConducible(){
		return materialBase.electricidadConducible() / 2
	}
	override method grsDeMetal(){
		return materialBase.grsDeMetal()
	}
	override method esRadioactivo(){
		return false
	}
	override method energiaProducida(){
		return materialBase * 2
	}
}
