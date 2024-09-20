import cosas.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar(unaCosa){
		cosas.remove(unaCosa)
	}

	method todoPesoPar(){
		
	}

	method hayAlgunoQuePesa(peso){

	}
// * `todoPesoPar()`: si el peso de cada uno de los objetos cargados es un número par.
// * `hayAlgunoQuePesa(peso)`: indica si hay alguno de los objetos cargados que tiene exactamente el peso indicado.
// * `elDeNivel(nivel)`: devuelve el primer objeto cargado que encuentre, cuyo nivel de peligrosidad coincida exactamente con el valor indicado.   
// * `pesoTotal()`: es la suma del peso del camión vacío (tara) y su carga. La tara del camión es de 1000 kilos.
// * `excedidoDePeso()`: indica si el peso total es superior al peso máximo, que es de 2500 kilos.
// * `objetosQueSuperanPeligrosidad(nivel)`: devuelve una colección con los objetos cargados que superan el nivel de peligrosidad indicado.
// * `objetosMasPeligrososQue(cosa)`: devuelve una colección con los objetos cargados que son más peligrosos que la cosa indicada.
// * `puedeCircularEnRuta(nivelMaximoPeligrosidad)` Puede circular si no está excedido de peso, y además, ninguno de los objetos cargados supera el nivel máximo de peligrosidad indicado.
}
