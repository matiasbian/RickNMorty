
class Morty{
	var energia = 0
	var mochila = #{}
	
	constructor(_energia){
		energia = _energia
	}
	
	method energia(nvaEnergia){
		energia = nvaEnergia
	}
	
	method recolectar(unMaterial){
		if(self.puedeRecolectar(unMaterial)){
			mochila.add(unMaterial)
			energia += unMaterial.aportePorRecolectar()
			energia -= unMaterial.descuentoPorRecolectar()
		}
	}
	
	method verificarMochila(){
		if (mochila.size()>=3){
			self.error("mochila llena, no se puede cargar mas de 3 materiales a la vez")
		}
	}
	
	method puedeRecolectar(unMaterial){
		self.verificarMochila()
		return unMaterial.grsDeMetal() < energia
	}
	
	method darObjetosA(unCompaniero){
		unCompaniero.intercambiar(mochila)
		mochila=#{}
	}
	
}

class Rick{
	var companiero
	var materiales
	var experimentos = #{}
	
	method companiero(nvoCompaniero){
		companiero = nvoCompaniero
	}
	method agregarExperimento(nvoExperimento){
		experimentos.add(nvoExperimento)
	}
	
	method intercambiar(mochila){
		self.recibirUnosMateriales(mochila)
	}
	method recibirUnosMateriales(unosMateriales){
		materiales = unosMateriales
	}
	method experimentosQuePudeRealizar(){
		return experimentos.filter {experimento => experimento.puedeConstruirse(materiales)}
	}
	method realizar(unExperimento){
		if(self.puedeRealizar(unExperimento)){
			self.removerElementosDeMochila(unExperimento.obtenerMateriales(materiales))
			unExperimento.efectoAlconstruir(self)
		}
	}
	method puedeRealizar(unExperimento){
		return self.experimentosQuePudeRealizar().contains(unExperimento)
	}
	method removerElementosDeMochila(nvosMateriales){
		materiales.removeAll(nvosMateriales)
	}
	//experimento.obtenerMateriales(materiales)
	//experimento.efectoAlConstruir(rick)
	
}