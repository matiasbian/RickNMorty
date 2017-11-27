import materiales.*


class Estrategia{
	
	var res = #{}
	 
	method obtenerMateriales(personaje,unExperimento){
		return res
	}

	method comando(materiales)
	
	method comandoAseguirSegun(materiales){
		var res1 = self.comando(materiales)
		res.add(res1)
		res1 = null
	}
}

class AlAzar inherits Estrategia{
	override method comando(materiales){
		return materiales.anyOne()
	}
	
}

class MenorCantDeMetal inherits Estrategia{
	override method comando(materiales){
		return materiales.min({material => material.grsDeMetal() })
	}
}

class MayorCantDeEnergia inherits Estrategia{
	override method comando(materiales){
		return materiales.max({material => material.energiaProducida()})
	}
}

class Ecologico inherits Estrategia{
	override method comando(materiales){
		var serVivo = self.seresVivos(materiales).anyOne()
		return if(materiales.esSerVivo(serVivo)) serVivo else self.elementosRadioactivos(materiales).anyOne()
	}
	method seresVivos(materiales){
		return materiales.filter {material => material.esSerVivo()}
	}
	method elementosRadioactivos(materiales){
		return materiales.filter {material => material.esRadioactivo()}
	}
}