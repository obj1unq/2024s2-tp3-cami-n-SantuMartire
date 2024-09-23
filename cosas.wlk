object knightRider {
	//KnightRider, arena a granel y residuos radioactivos son 1 bulto.
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method valorBulto() {return 1}
}

object bumblebee {
	//pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot
	//Bumblebee y embalaje de seguridad son dos bultos
	var estado = auto
	method peso() { return 800 }
	method nivelPeligrosidad() {return estado.nivelPeligrosidad()}
	method valorBulto() {return 2}

	method transformarEnAuto() {
		estado = auto
	}

	method TransformarEnRobot() {
		estado = robot
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method consecuencia() {
		self.TransformarEnRobot()
	}
}

object auto {
	method nivelPeligrosidad() {return 15}
}

object robot {
	method nivelPeligrosidad() {return 30}
}

object ladrillos {
	//cada ladrillo pesa 2 kilos, la cantidad de ladrillos que tiene puede variar. La peligrosidad es 2.
	//Paquete de ladrillos es 1 hasta 100 ladrillos, 2 de 101 a 300, 3 301 o más
	var property cantidad = 0
	method peso() {return cantidad * 2}
	method nivelPeligrosidad() {return 2}

	method agregarLadrillos(cant) {
		cantidad = cantidad + cant
	}

	method sacarLadrillos(cant) {
		cantidad = cantidad - cant
	}

		method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method valorBulto() {
		return if (cantidad.between(0, 100)) {1}
		else if (cantidad.between(101, 300)) {2}
		else {3}
	}

	method consecuencia() {
		self.agregarLadrillos(12)
	}
}

object arenaGranel{
	//el peso es variable, la peligrosidad es 1.
	//KnightRider, arena a granel y residuos radioactivos son 1 bulto.
	var property peso = 0
	method nivelPeligrosidad() {return 1}
	method valorBulto() {return 1}

	method agregarPeso(cant) {
		peso = peso + cant
	}

	method sacarPeso(cant) {
		peso = peso - cant
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method consecuencia() {
		self.agregarPeso(20)
	}
}


object bateria {
	//el peso es 300 kilos si está con los misiles o 200 en otro caso.En cuanto a la peligrosidad es 100 si está con los misiles y 0 en otro caso.
	//antiaérea: 1 si no tiene misiles, 2 si tiene
	var property tieneMisiles = false

		method cargaMisiles() {
		tieneMisiles = true
	}

	method remueveMisiles() {
		tieneMisiles = false
	}

	method peso() {
		return if (tieneMisiles) {300}
		else {200}
	}

	method nivelPeligrosidad() {
		return if (tieneMisiles) {100}
		else {0}
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method valorBulto() {
		return if (tieneMisiles) {2}
		else {1}
	}

	method consecuencia() {
		self.cargaMisiles()
	}
}


object contenedor {
	//un contenedor puede tener otras cosas adentro. El peso es 100 + la suma de todas las cosas que estén adentro. Es tan peligroso como el objeto más peligroso que contiene. Si está vacío, su peligrosidad es 0.
	//1 + los bultos que tiene adentro.
	var property cosas = #{}

	method llenar(cosa) {
		cosas.add(cosa)
	} 

	method peso() {
		return 100 + (cosas.sum({ cosa => cosa.peso() }))
	}

	method nivelPeligrosidad() {
		return if (cosas.isEmpty()) {0}
		else {(cosas.map({ cosa => cosa.nivelPeligrosidad() })).max()}
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}
	
	method valorBulto() {
		return 1 + (cosas.sum({ cosa => cosa.valorBulto() }))
	}

	method consecuencia() {
		cosas.forEach({cosa => cosa.consecuencia()})
	}
}


object residuos {
	//el peso es variable y su peligrosidad es 200.
	//KnightRider, arena a granel y residuos radioactivos son 1 bulto.
	var property peso = 0
	method nivelPeligrosidad() {return 200}
	method valorBulto() {return 1}

	method agregarPeso(cant) {
		peso = peso + cant
	}

	method sacarPeso(cant) {
		peso = peso - cant
	}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}

	method consecuencia() {
		self.agregarPeso(15)
	}
}


object embalaje {
	//es una cobertura que envuelve a cualquier otra cosa. El peso es el peso de la cosa que tenga adentro. El nivel de peligrosidad es la mitad del nivel de peligrosidad de lo que envuelve.
	//Bumblebee y embalaje de seguridad son dos bultos
	var property cosaEmbalada = contenedor
	method peso() {return cosaEmbalada.peso()}
	method nivelPeligrosidad() {return (cosaEmbalada.nivelPeligrosidad()/2)}
	method valorBulto() {return 1}

	method esMasPeligrosaQue(cosa) {
		return (self.nivelPeligrosidad() > cosa.nivelPeligrosidad())
	}
}

