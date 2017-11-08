
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
		unCompaniero.recolectar(mochila)
		mochila=#{}
	}
	
}