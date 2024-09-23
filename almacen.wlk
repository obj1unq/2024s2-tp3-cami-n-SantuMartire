object almacen {
    const property cosasAlmacenadas = #{}
    var property bultosMax = 3

    method cargar(cosasAlmacen) {
        cosasAlmacenadas.addAll(cosasAlmacen)
    }

    method totalBultos() {
        return (cosasAlmacenadas.map({ cosa => cosa.valorBulto() })).sum()
    }
}