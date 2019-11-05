import vendedores.*

class CentroDeDistribucion{
	var property ciudad
	var property vendedores = []
	
	method agregarVendedor(vendedor){
		if(vendedores.contains(vendedor)){
			self.error("ese vendedor ya esta registrado")
		}
		vendedores.add(vendedor)
		
	}
	method vendedorEstrella(){
		return vendedores.max({vendedor => vendedor.puntajeTotal()})
	}
	method puedeCubrir(unaCiudad){
		return vendedores.any({vendedor => vendedor.puedeTrabajarAlli(unaCiudad)})
	}
	method coleccionDeVendedoresGenericos(unTipoDeCertificacion){
		var vendedoresGenericos = []
		vendedoresGenericos = vendedores.filter({vendedor => vendedor.tieneUnaQueNoSea(unTipoDeCertificacion)})
		return vendedoresGenericos	
	}
	method esRobusto(){
		var vendedoresFirmes = []
		vendedoresFirmes = vendedores.all({vendedor => vendedor.esFirme()})
		return vendedoresFirmes.size() >= 3
	}
	method repartirCertificacion(unaCertificacion){
		vendedores.ForEach({vendedor => vendedor.certificaciones().add(unaCertificacion)})
	}
}
