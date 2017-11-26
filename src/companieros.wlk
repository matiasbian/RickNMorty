import Rick.*

class Companiero{
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
		unMaterial.realizoAcciones(self)
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
	
	method mochilaLlena()
	
	method efectoDeRick()
}

class Morty inherits Companiero{
	
	override method recolectar(unMaterial){
		super(unMaterial)
		self.cambiosEnEnergia(unMaterial)
	}
	
	method cambiosEnEnergia(unMaterial){
		energia += unMaterial.aportePorRecolectar()
		energia -= unMaterial.descuentoPorRecolectar()
	}

	
	override method mochilaLlena(){
		return mochila.size() >3
	}
	
	override method puedeRecolectar(unMaterial){
		super(unMaterial)
		return super(unMaterial) < energia
	}
	
	override method efectoDeRick(){
		
	}
	
}

class Summer inherits Companiero{
	
	override method recolectar(unMaterial) {
		super(unMaterial)
		self.cambiosEnEnergia(unMaterial)
		
	}
	
	method cambiosEnEnergia(unMaterial){
		energia += unMaterial.aportePorRecolectar()
		energia -= unMaterial.descuentoPorRecolectar()*0.8
	}
	
	override method mochilaLlena(){
		return mochila.size()>2
	}
	
	override method puedeRecolectar(unMaterial){
		super(unMaterial)
		return super(unMaterial)*0.8 < energia
	}
	
	override method efectoDeRick(){
		
	}
	
}

class Jerry inherits Companiero{
	var buenHumor = true
	var sobreExitado = false
	var capacidadMochila = 3
	
	method estaDeBuenHumor(){
		return buenHumor
	}
	
	method estaSobreExitado(){
		return sobreExitado
	}
	
	method calmarSobreExitacion(){
		sobreExitado = false
	}
	
	override method recolectar(unMaterial){
		if(self.estaAfectadoDeAnimo()){
			self.recolectarSiSobreExitado(unMaterial)
			self.recolectarSiMalHumorado(unMaterial)
		}
		else {
			super(unMaterial)
			self.cambiosEnEnergia(unMaterial)
			self.cambioEstadoDeAnimo(unMaterial)
			}
		
	}
	
	method estaAfectadoDeAnimo(){
		return !buenHumor || sobreExitado
	}
	method recolectarSiSobreExitado(unMaterial){
		
		if(sobreExitado){
			if(!self.puedeRecolectar(unMaterial)){
			self.error("No se puede recolectar")
				}
			var vaciarMochila = #{0,1,2,3}.anyOne()
			if(vaciarMochila==1){
				mochila.clear()
			}
			mochila.add(unMaterial)
			unMaterial.realizoAcciones(self)
			self.cambiosEnEnergiaYEstadoDeAnimo(unMaterial)
		}
	}
	
	method recolectarSiMalHumorado(unMaterial){
		if (!buenHumor){
			if(!self.puedeRecolectar(unMaterial)){
			self.error("No se puede recolectar")
				}
			var materialALevantar = #{}
			materialALevantar.add(unMaterial)
			mochila.add(materialALevantar.anyOne())
			self.cambiosEnEnergiaYEstadoDeAnimo(unMaterial)
		}
	}
	
	method cambioEstadoDeAnimo(unMaterial){
		if (unMaterial.esSerVivo()){
			buenHumor = true
		}
		
		if (unMaterial.esRadioactivo()){
			sobreExitado=true
			capacidadMochila=6
		}
	}
	
	method cambiosEnEnergia(unMaterial){
		energia += unMaterial.aportePorRecolectar()
		energia -= unMaterial.descuentoPorRecolectar()
	}
	
	method cambiosEnEnergiaYEstadoDeAnimo(unMaterial){
		self.cambiosEnEnergia(unMaterial)
		self.cambioEstadoDeAnimo(unMaterial)
	}
	
	override method mochilaLlena(){
		return mochila.size()>capacidadMochila
	}
	
	override method puedeRecolectar(unMaterial){
		
		super(unMaterial)
		return super(unMaterial) < energia
	}
	
	
	override method efectoDeRick(){
		buenHumor=false
	}
}
