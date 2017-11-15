import materiales.*

//CORRECCION: Un experimento no es un material, a lo sumo puede construir un material
//ESta mal que a un experimento le pueda preguntar gramos de metal, los gramos de metal se les puede
//preguntar al material que el experimento construye
class Experimento inherits Material {
	var componentes
	
	method puedeConstruirse(materiales)	

	method efectoAlConstruir(rick)	
	
	method obtenerMateriales(materiales)
}
//CORRECCION por que tenés esta clase igualita al Experimento?
class ExperimentoDeEfecto {
	var componentes
	
	method puedeConstruirse(materiales)	

	method efectoAlConstruir(rick)	
	
	method obtenerMateriales(materiales)
	
}

//CORRECCION: Separar la bateria(material) del experimento crear bateria

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
		
		if (!self.puedeConstruirse(materiales)){
			self.error("No tiene los materiales necesarios")
		}
		
		//CORRECICON, también podrían usar una sola coleccion, #{materiales.find(condicion1), materiales.find(condicion2)}
		return #{materiales.find(condicion1)} + #{materiales.find(condicion2)}
	}
	
	override method efectoAlConstruir(rick){
		//Mejor delegar en rick.disminuirEnergiaCompaniero(5)
		rick.companiero().energia( rick.companiero().energia() - 5 ) 
		
		var mat = self.obtenerMateriales(rick.materiales()) // guardo los materiales que necesito para crear la bateria	
		rick.recibirUnosMateriales(#{new Bateria(mat)})	// hago una bateria con la cantidad de metal de sus materiales
		
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

//Separar el material Circuito del experimento crear Circuito
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
		if (!self.puedeConstruirse(materiales)){
			self.error("No tiene los materiales necesarios")
		}
		
		return materiales.all(condicion)
	}
	
	override method efectoAlConstruir(rick){
		rick.energia( rick.energia() - 5 ) 
		
		var mat = self.obtenerMateriales(rick.companero().mochila()) // guardo los materiales que necesito para remover 
		rick.companiero().recolectar(new Circuito(mat))	
		rick.remover(mat)	
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

class ShockElectrico inherits ExperimentoDeEfecto {
	
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
		//CORRECCION, por más que se una lista, puede seguir pasando que sea el mismo materia,
		return [materiales.find(condicion1)] + [materiales.find(condicion2)] 
	}
	
	
	
	override method efectoAlConstruir(rick){
		//CORRECCION; tal vez convenga pasarle los materiales por parametro, por que no está 
		//garantizado que el find siempre devuelva el mismo objeto
		//podria ser que remuevas unos materiales, pero el calculo del efecto uses otro
		rick.companero().energia(rick.companero().energia() + self.energiaResultante(self.obtenerMateriales(rick.Mochila())))
	}
	
	method energiaResultante(materiales){
		return materiales.first().energiaProducida() + materiales.last().electricidadConducible()
	}
	
	
	
	
	
}









