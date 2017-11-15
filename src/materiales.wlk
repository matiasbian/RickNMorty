
class Material {
	
//CORRECCION: Lo importante del material 
//son los mensajes que entienden, no está bien
//definir variables, ya que muchas subclases
//cambian la manera que tiene de calcular los valores
//al contestar el mensaje. 
//SI ocurriera que para un acaracterística, siempre
//el valor se debe recordar en una variable entonces estaría
//bien para esa característica.
	
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
	
	
	//CORRECCION es raro que el getter sea abstracto pero el setter lo guarda en una variable
	//para ser consistente el getter debería revolver el valor del setter.
	
	method esRadioactivo ()
	
	//CORRECCION queda raro que le puedas decir a un material que ahora es radiactivo, pero cuando le preguntas si lo 
	//(como por ejemplo un fleb menor de 15 años) te contesta que no
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
	//CORRECCION, esto no está en el enunciado
	method aportePorRecolectar(){
		return self.energiaProducida()
	}
	  
	 
}

class Lata inherits Material {
//CORRECCION: La univa variable que necesita 
//son los gramos de metal, pero por herencia
//recibe las otras tres variables.
//Lo mejor es definir la variable para esta clase
//nada mas.
	
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
	//CORRECCION hereda variables innecesarias
	//y sobrescribe toodo los metodos. 
	//No sirve la herencia aca
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
	//CORRECCION la herencia no aporta nada
	const matComida =  #{}
	var edad
	
	constructor(_edad){
		edad = _edad
	}
	method comer(unaComida){
		matComida.add(unaComida)
	}
	override method electricidadConducible(){
		return matComida.min({material => material.electricidadConducible()}).electricidadConducible()
	}
	override method esRadioactivo(){
		return edad > 15 
	}
	override method grsDeMetal(){
		return matComida.sum {material => material.grsDeMetal()} 	
	}
	override method energiaProducida(){
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
	//CORRECCION la herencia no aporta nada
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
		//CORRECCION: No está testeado, hay un bag sencillo:
		//es materialBase.energiaProducida() * 2
		return materialBase * 2
	}
}
