
class Morty{
	var energia
	var mochila = #{}
	
	method recolectar(unMaterial){
		if(self.puedeRecolectar(unMaterial)){
			mochila.add(unMaterial)
			energia += unMaterial.energiaProducida()
			energia -= unMaterial.grsDeMetal()
		}
	}
	
	method verificarMochila(){
		if (mochila.size()>=3){
			self.error("mochila llena, no se puede cargar mas de 3 materiales a la vez")
		}
	}
	
	method puedeRecolectar(unMaterial){
		self.verificarMochila()
		return (unMaterial.grsDeMetal()<unMaterial.energiaProducida())//esta parte me hace ruido por el tema de que no empieza con energía entonces no sé con qué comprar
	}
	
	method darObjetosA(unCompaniero){
		unCompaniero.recolectar(mochila)
		mochila=#{}
	}
	
}