import materiales.*


class Estrategia{
	
	var res = #{}

	method obtenerMaterial(materiales){
		var material = self.estrategia(materiales)
		res.add(material)
		material = null
		return res
	}
	method estrategia(materiales)
}

class AlAzar inherits Estrategia{
	override method estrategia(materiales){
		return materiales.anyOne()
	}
	
}

class MenorCantDeMetal inherits Estrategia{
	override method estrategia(materiales){
		return materiales.min({material => material.grsDeMetal() })
	}
}

class MayorCantDeEnergia inherits Estrategia{
	override method estrategia(materiales){
		return materiales.max({material => material.energiaProducida()})
	}
}

class Ecologico inherits Estrategia{
	override method estrategia(materiales){
		var serVivo = self.seresVivos(materiales).anyOne()
		return if(materiales.esSerVivo(serVivo)) serVivo else self.elementosRadioactivos(materiales).anyOne()
	}
	method seresVivos(materiales){
		return materiales.filter {material => material.esSerVivo()}
	}
	method elementosRadioactivos(materiales){
		return materiales.filter {material => ! material.esRadioactivo()}
	}
}