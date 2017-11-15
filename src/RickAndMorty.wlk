
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
		//CORRECCION: Si no puede debe romper!!!
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
		//CORRECCION Acá esta mezclando preguntas booleanas (puedo hacer algo sí o no) con validación
		//Si Morty tiene 3 elementos y le preguntan si puede recolectar algo tiene que decir "no" (false) 
		//no romper.
		//pero si a Morty le piden que recolecte algo y tiene la mochila llena, ahí si debe romper
		self.verificarMochila()
		//CORRECCION: Acá anda mal el fleeb, el fleeb requiere el doble de los gramos de metal
		//Por eso en lugar de preguntarle los gramos de metal al material, hay que preguntarle la energia necesaria
		//para recolectar, en este caso el mensaje lo llamaron: "descuentoPorRecolectar"
		return unMaterial.grsDeMetal() < energia
	}
	
	method darObjetosA(unCompaniero){
		unCompaniero.intercambiar(mochila)
		mochila=#{}
	}
	
}

class Rick{
	var companiero
	//CORRECCION: Los materiales deberian estar inicializados
	var materiales
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
		//CORRECCION: Se perdieron los materiales que tenia antes :(
		//Deberia ser un addAll
		materiales = unosMateriales
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
		//CORRECCION: Es más directo return unExperimento.puedeConstruirse(materiales)
		//y para evitar la duplicacion en el filter anterior, usar self.puedeRealizar(experimento)
		return self.experimentosQuePudeRealizar().contains(unExperimento)
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