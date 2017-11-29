import materiales.*

class Experimento {
	var componentes
	
	method puedeConstruirse(materiales)	

	method efectoAlConstruir(rick)	
	
	method obtenerMateriales(materiales,estrategias)
	
	method ejecutarConEstrategia(estrategia,materiales){
		var materialesConEstrategia =#{}
		
		materiales.forEach{material => self.comandoASeguir(material,materialesConEstrategia,materiales,estrategia)}								 
		return materialesConEstrategia
		
	}
	method comandoASeguir(material,materialesAGuardar,materiales,estrategia){
		return materialesAGuardar.add(estrategia.obtenerMateriales(materiales))
		
		
	
	}
	method guardarYEliminarMaterial(estrategia,maeterial)
}


class Bateria inherits Experimento{
	
	const condicion1 = {mat => mat.grsDeMetal() > 200} 
	const condicion2 = { mat => mat.esRadioactivo()}
	
	

	
	
	override method puedeConstruirse(materiales){
		return materiales.any ( condicion1 ) && materiales.any ( condicion2 )
	}
	
	override method obtenerMateriales(materiales,estrategia){
		
		if (!self.puedeConstruirse(materiales)){
			self.error("No tiene los materiales necesarios")
		}
		
		return self.ejecutarConEstrategia(estrategia,#{materiales.find(condicion1)} + #{materiales.find(condicion2)})
	}
	
	override method efectoAlConstruir(rick){
		rick.companiero().energia( rick.companiero().energia() - 5 ) 
		
		var mat = self.obtenerMateriales(rick.materiales()) // guardo los materiales que necesito para crear la bateria	
		rick.recibirUnosMateriales(#{new BateriaMaterial(mat)})	// hago una bateria con la cantidad de metal de sus materiales
		
	}
	
	

	
	
}


class Circuito inherits Experimento {
	
	const condicion = {material => material.electricidadConducible() > 5}

		
	override method puedeConstruirse(materiales){
		return materiales.any(condicion)
	}
	
	override method obtenerMateriales(estrategia,materiales){
	
		if (!self.puedeConstruirse(materiales)){
			self.error("No tiene los materiales necesarios" + materiales  )
		}
		
		return self.ejecutarConEstrategia(estrategia,materiales.filter(condicion))
	}
	
	override method efectoAlConstruir(rick){
		rick.companiero().energia( rick.companiero().energia() - 5 ) 
		
		var mat = self.obtenerMateriales(rick.materiales()) // guardo los materiales que necesito para remover 
				
		rick.companiero().recolectar(new CircuitoMaterial(mat))	
		rick.removerElementosDeMochila(mat)	
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
	
	override method obtenerMateriales(materiales,estrategia){
		if (!self.puedeConstruirse(materiales)){
			self.error("No tiene los materiales necesarios" + materiales  )
		}
		
		return self.ejecutarConEstrategia(#{materiales.find(condicion1)} + #{materiales.find(condicion2)}) 
	}
	
	
	override method efectoAlConstruir(rick){
		rick.companiero().energia(rick.companiero().energia() + self.energiaResultante(self.obtenerMateriales(rick.materiales())))
	}
	
	method energiaResultante(materiales){
		return materiales.first().energiaProducida() + materiales.last().electricidadConducible()
	}
	
	
	
	
	
}









