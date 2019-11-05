class Vendedores{
	var property provincias = [ ]
	var property certificaciones = #{}
	var property esInfluyente = false
	
	method puedeTrabajarAlli(unaCiudad)
	
	method esVersatil(unaCertificacion){
		return self.tieneTresCertificaciones() and self.tieneUnaSobreProductos(unaCertificacion) 
		and self.tieneUnaQueNoSea(unaCertificacion) 
	}
	method esFirme(){
		return self.puntajeTotal() >= 30
	}
	
	method tieneTresCertificaciones(){
		return certificaciones.size() >= 3
	}
	method tieneUnaSobreProductos(unaCertificacion){
		return certificaciones.contains(unaCertificacion)
	}
	method tieneUnaQueNoSea(unaCertificacion){
		return not certificaciones.any(unaCertificacion)
	}
	method otorgarCertificacion(unaCertificacion){
		certificaciones.add(unaCertificacion)
	}
	method puntajeTotal(){
		return certificaciones.sum({certificado => certificado.puntosQueOtorga()})
	}
	method todasLasCertificaciones(){
		return certificaciones.map().assSet()
	} 
	
}

class VendedorFijo inherits Vendedores{
	var property ciudad
	
	override method puedeTrabajarAlli(unaCiudad){
		return unaCiudad == ciudad
	}
	override method esInfluyente(){
		return false
	}
	 
}

class Viajante inherits Vendedores{
	method habilitacion(unaProvincia){
		provincias.add(unaProvincia)
	}
	override method puedeTrabajarAlli(unaCiudad){
		return provincias.any({unaCiudad.provincia()})
	}
	override method esInfluyente(){
		return self.poblacionTotalDePovinciasDondeEstoyHabilitado() >= 10000000
	}
	method poblacionTotalDePovinciasDondeEstoyHabilitado(){
		return provincias.sum({provincia => provincia.poblacion()})
	}
}

class ComercioCorresponsal inherits Vendedores{
	var property sucursales = []
	
	override method puedeTrabajarAlli(unaCiudad){
		return sucursales.any({unaCiudad})
	}
	override method esInfluyente(){
		return sucursales.size() >= 5  or self.todasLasProvincias().size() >= 3
	}
		
	method todasLasProvincias(){
		return sucursales.map({ciudad => ciudad.provincia()}).asSet()
	}

}

// debe tener sucursales en al menos 5 ciudades, 
// o bien en al menos 3 provincias considerando la provincia de cada ciudad donde tiene sucursal.

class Provincias {
	var property poblacion = 0
}

class Ciudades {
	var property provincia 
	
	method vendedorPuedeTrabajar(unVendedor){
		return (unVendedor.puedeTrabajarAlli(self))
	}
}

class Certificacion {
	var property puntosQueOtorga
}

class CertificacionDeProductos inherits Certificacion{
	override method puntosQueOtorga(){
		return 20
	}
}

class CertificacionDeOtroTipo inherits Certificacion{
	override method puntosQueOtorga(){
		return 10 
	}
}
