import cosas.*
import almacen.*

object camion {
	const property cosas = #{}

	const tara = 1000
	const pesoMax = 2500
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar(unaCosa){
		cosas.remove(unaCosa)
	}

	method todoPesoPar(){
		//si el peso de cada uno de los objetos cargados es un número par
		return cosas.all({ cosa => cosa.peso().even() })
	}

	method hayAlgunoQuePesa(peso){
		//indica si hay alguno de los objetos cargados que tiene exactamente el peso indicado
		return cosas.any({ cosa => cosa.peso() == peso })
	}

	method elDeNivel(nivel){
		//devuelve el primer objeto cargado que encuentre, cuyo nivel de peligrosidad coincida exactamente con el valor indicado
		return (cosas.find({ cosa => cosa.nivelPeligrosidad() == nivel }))
	}

	method pesoTotal(){
		//es la suma del peso del camión vacío (tara) y su carga. La tara del camión es de 1000 kilos
		return tara + cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso(){
		//indica si el peso total es superior al peso máximo, que es de 2500 kilos
		return (self.pesoTotal() > pesoMax)
	}

	method objetosQueSuperanPeligrosidad(nivel){
		//devuelve una colección con los objetos cargados que superan el nivel de peligrosidad indicado.
		return (cosas.filter({ cosa => cosa.nivelPeligrosidad() > nivel }))
	}

	method objetosMasPeligrososQue(cosa){
		//devuelve una colección con los objetos cargados que son más peligrosos que la cosa indicada.
		return (cosas.filter({ cosa => cosa.esMasPeligrosaQue(cosa) }))
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad){
		//Puede circular si no está excedido de peso, y además, ninguno de los objetos cargados supera el nivel máximo de peligrosidad indicado
		return (not(self.excedidoDePeso())) and (self.objetosQueSuperanPeligrosidad(nivelMaximoPeligrosidad) == #{})
	}


//----------------------------Agregados al camión------------------------------------

	method tieneAlgoQuePesaEntre(min,max) {
		//indica si el peso de alguna de las cosas que tiene el camión está en ese intervalo
		return (cosas.any({ cosa => (cosa.peso() >= min) and (cosa.peso() <= max) }))
	}

	method cosaMasPesada() {
		//la cosa más pesada que tenga el camión
		return (cosas.max({ cosa => cosa.peso() }))
	}

	method pesos() {
		//devuelve una lista con _los pesos_ de cada cosa que tiene el camión
		return (cosas.map({ cosa => cosa.peso() }))
	}

	method totalBultos() {
		//la suma de la cantidad de bultos que está transportando.
		return (cosas.map({ cosa => cosa.valorBulto() })).sum()
	}
	



//----------------------------Transporte------------------------------------

	method transportar(destino, camino) {
		self.validarTransporte(destino, camino)
		destino.cargar(cosas)
		cosas.removeAll(cosas)
	}

	method validarTransporte(destino,camino) {
		self.validarPeso()
		self.validarBultos(destino)
		self.validarCamino(camino)
	}

	method validarPeso() {
		//El camión no tiene que estar excedido de peso
		if (self.excedidoDePeso()) {self.error("esta excedido de peso")}
	}

	method validarBultos(destino) {
		//El almacén tiene una cantidad de bultos máximos que no puede superar. Por ejemplo, si contiene arena a granel (1 bulto), el máximo de bultos
		//del almacén se configura en 3, y el camión contiene a Bumblebee y Knight Rider (3 bultos), entonces no se puede transportar.
		if ((self.totalBultos() + destino.totalBultos()) > destino.bultosMax()) {self.error("esta excedido de bultos")}
	}

	method validarCamino(camino) {
		if (not camino.camionPuedePasar(self)) {self.error("no puede pasar por " + camino)}
	}
}

object rutaNueve {
	//El nivel de peligrosidad de la ruta 9 es 11, solo se puede usar la ruta 9 en los casos en "puedaCircularEnRuta" del punto 1
	const nivelPeligrosidad = 11

	method camionPuedePasar(camion) {
		return camion.puedeCircularEnRuta(nivelPeligrosidad)
	}
}

object vecinales {
	//Los caminos vecinales tienen un peso máximo soportado que es configurable. El peso total del camión no puede ser superior al peso tolerado
	var property  pesoMax = 0

	method camionPuedePasar(camionD) {
		return (camion.pesoTotal() < pesoMax)
	}
}