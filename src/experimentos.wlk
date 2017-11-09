import materiales.*

class Experimento inherits Material {
	var componentes
	
	method puedeConstruirse(materiales)	

	method efectoAlConstruir(rick)	
	
	method obtenerMateriales(materiales){
		if (!self.puedeConstruirse(materiales)){
			self.error("No tiene los materiales necesarios")
		}
		
		return 0
	}
	
}

class Bateria inherits Experimento{
	
	const condicion1 = {mat => mat.grsDeMetal() > 200} 
	const condicion2 = { mat => mat.esRadioactivo()}
	
	
	constructor (){
		
	}
	
	constructor (_componentes){
		componentes = _componentes
	}
	
 // metodos como experimento
	
	
	override method puedeConstruirse(materiales){
		return materiales.any ( condicion1 ) && materiales.any ( condicion2 )
	}
	
	override method obtenerMateriales(materiales){
		
		super(materiales)
		
		return [materiales.find(condicion1)] + [materiales.find(condicion2)]
	}
	
	override method efectoAlConstruir(rick){
		rick.energia( rick.energia() - 5 ) 
		
		var mat = self.obtenerMateriales(rick.companero().mochila()) // guardo los materiales que necesito para remover 
		rick.remover(mat)		
		rick.recolectar(new Bateria(mat.sum({material => material.grsDeMetal()})))	// hago una bateria con la cantidad de metal de sus materiales
		
	}
	
	
	
	// metodos de Material
	
		
	
	override method electricidadConducible(){
		return 0
	}
	
	override method grsDeMetal(){
		return componentes.sum( {com => com.grsDeMetal()})	
	}
	
	override method esRadioactivo(){
		return true
	}
	
	override method energiaProducida(){
		return 2 * self.grsDeMetal()
	}
	
	
}


class Circuito inherits Experimento {
	
	const condicion = {material => material.electricidadConducible() > 5}

	constructor(){
		
	}
	
	constructor (_componentes){
		componentes = _componentes
	}
	
	//metodos como experimento
	
	override method puedeConstruirse(materiales){
		return materiales.any(condicion)
	}
	
	override method obtenerMateriales(materiales){
		super(materiales)
		
		return materiales.all(condicion)
	}
	
	override method efectoAlConstruir(rick){
		
		
	}
	
	// metodos como material
	
	
	override method electricidadConducible(){
		return componentes.sum({ comp => comp.electricidadConducible() }) * 3
	}
	
	override method grsDeMetal(){
		return componentes.sum({ comp => comp.grsDeMetal()})
	}
	
	override method esRadioactivo(){
		return componentes.any({ comp => comp.esRadioactivo()})
	}
	
	override method energiaProducida(){
		return 0
	}
	
}

class ShockElectrico inherits Experimento {
	
	const condicion1 = {material => material.energiaProducida() > 0}
	const condicion2 = {material => material.electricidadConducible() > 0}
	
	constructor(){
		
	}
	
	//metodos como experimento
	
	override method puedeConstruirse(materiales){
		return materiales.any(condicion1) && materiales.any(condicion2)
	}
	
	override method obtenerMateriales(materiales){
		super(materiales)
		
		return [materiales.find(condicion1)] + [materiales.find(condicion2)] 
	}
	
	
	override method efectoAlConstruir(rick){
		rick.companero().energia(rick.companero().energia() + self.energiaResultante(self.obtenerMateriales(rick.Mochila())))
	}
	
	method energiaResultante(materiales){
		return materiales.first().energiaProducida() + materiales.last().electricidadConducible()
	}
	
}









