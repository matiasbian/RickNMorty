
class Morty{
	var energia = 0
	var mochila = #{}
	
	constructor(_energia){
		energia = _energia
	}
	
	method energia(nvaEnergia){
		energia = nvaEnergia
	}
	
	method energia(){
		return energia
	}
	
	method mochila(){
		return mochila
	}
	
	method recolectar(unMaterial){
		if(!self.puedeRecolectar(unMaterial)){
			self.error("No se puede recolectar")
		}
		
		
		mochila.add(unMaterial)
		energia += unMaterial.aportePorRecolectar()
		energia -= unMaterial.descuentoPorRecolectar()
	}
	
	method mochilaLlena(){
		return mochila.size()>3
	}
	
	method puedeRecolectar(unMaterial){
		if (self.mochilaLlena() ){
			self.error("Mochila llena")
		}
		return unMaterial.descuentoPorRecolectar() < energia
	}
	
	method darObjetosA(unCompaniero){
		unCompaniero.intercambiar(mochila)
		mochila.clear()
	}
	
}

class Rick{
	var companiero
	var materiales = #{}
	var experimentos = #{}
	
	method companiero(nvoCompaniero){
		companiero = nvoCompaniero
	}
	
	method companiero(){
		return companiero
	}
	
	method agregarExperimento(nvoExperimento){
		experimentos.add(nvoExperimento)
	}
	
	method intercambiar(mochila){
		self.recibirUnosMateriales(mochila)
	}
	method recibirUnosMateriales(unosMateriales){
		materiales.addAll( unosMateriales )
	}
	method experimentosQuePudeRealizar(){
		return experimentos.filter {experimento => experimento.puedeConstruirse(materiales)}
	}
	method realizar(unExperimento){
		if(!self.puedeRealizar(unExperimento)){
			self.error("No se puede realizar experimento")
		}
		var elemABorrar = unExperimento.obtenerMateriales(materiales)
		unExperimento.efectoAlConstruir(self)
		self.removerElementosDeMochila(elemABorrar)
		
	}
	method puedeRealizar(unExperimento){
		return unExperimento.puedeConstruirse(materiales)
	}
	
	method materiales (){
		return materiales
	}
	method removerElementosDeMochila(nvosMateriales){
		materiales.removeAll(nvosMateriales)
	}
	//experimento.obtenerMateriales(materiales)
	//experimento.efectoAlConstruir(rick)
	
}