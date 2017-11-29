import companieros.*

class Rick{
	var companiero
	var materiales = #{}
	var experimentos = #{}
	
	method companiero(nvoCompaniero){
		companiero = nvoCompaniero
		companiero.efectoDeRick()
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
	method realizar(unExperimento,estrategia){
		if(!self.puedeRealizar(unExperimento)){
			self.error("No se puede realizar experimento")
		}
		var elemABorrar = unExperimento.obtenerMateriales(materiales,estrategia)
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

