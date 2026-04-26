object rolando {
    var capacidadMochila = 2
    const artefactosEnTotal = #{}
    var ubicacion = castillo 
    var poderBase = 5
    const historialDeRecoleccion = []
    

    method ubicacion(_ubicacion){ 
        ubicacion = _ubicacion 
    }
    method capacidadMochila(){ 
        return capacidadMochila
    }
    method capacidadMochila(_capacidadMochila){ 
        capacidadMochila = _capacidadMochila 
    }
    method artefactosEnTotal(){
        return artefactosEnTotal
    }
    method llevarArtefacto(artefacto){ 
        historialDeRecoleccion.add(artefacto)
        if(artefactosEnTotal.size() < capacidadMochila){
            artefactosEnTotal.add(artefacto)
            
        }
    }
    method llevarA(ubicacion){
        ubicacion.añadirArtefacto(artefactosEnTotal)
        artefactosEnTotal.clear()
    }
    method tieneArtefacto(artefacto) {
        return self.artefactosEnTotal().contains(artefacto)
    }
    method historialDeRecoleccion(){ 
        return historialDeRecoleccion
    }
    method poderBase(){
        return poderBase 
    }
    method poderBase(_poderBase){
        poderBase = _poderBase 
    }
    method pelearBatalla() {
        poderBase = poderBase + 1
        artefactosEnTotal.forEach( {artefacto => artefacto.utilizar()})
    }
    method poderTotal(){ 
        return poderBase + self.poderDeArtefactos()
    }
    method poderDeArtefactos(){ 
        return artefactosEnTotal.sum({artefacto => artefacto.poderQueAporta(self)})
    }
    method poseeArtefactoEnMorada(){ 
        return ubicacion.hayArtefactos()
    }
    method artefactoMasPoderosoEnMorada() {
      return ubicacion.artefactoMasPoderoso(self)
    }
    method puedeVencer(enemigos){ 
        return enemigos.filter({enemigo => self.poderTotal() > enemigo.poderTotal()})
    }
    method apoderarseDeMorada(enemigos) {
      return self.puedeVencer(enemigos).map({enemigo => enemigo.morada()})
    }
    method rolandoEsElMasPoderoso(enemigos) {
        return enemigos.all({ enemigo => self.poderTotal() > enemigo.poderTotal() })
    }
}
// LUGARES 
object castillo { 
    const baulDeArtefactos = #{}

    method inventario() {
        return baulDeArtefactos
    }
    method estaArtefacto(artefacto) {
      return self.inventario().contains(artefacto)
    }
    method añadirArtefacto(artefacto){ 
        baulDeArtefactos.addAll(artefacto)
    }
    method artefactoMasPoderoso(personaje){
        return baulDeArtefactos.max({artefacto => artefacto.poder(personaje)})
    }
    method hayArtefactos(){ 
        return not inventario().isEmpty()
    }
}
object fortalezaDeAcero {}
object palacioDeMarmol {}
object torreDeMarfil {}
// OBJETOS 
object espadaDelDestino {
    var fueUsada = false 

    method poderQueAporta(personaje) {
        if(fueUsada){
            return personaje.poderBase() / 2
        }
        else{
            return personaje.poderBase()
        }
    }
    method utilizar() {
      fueUsada = true
    }
}
object collarDivino {
     var vecesUsada = 0 

    method poderQueAporta(personaje){ 
        if(personaje.poderBase() > 6){
            return 3 + vecesUsada
        }
        return 3 
    }
    method utilizar() {
      vecesUsada = vecesUsada + 1 
    }
}
object armadura {
    method poderQueAporta(personaje) {
      return 6 
    }
    method utilizar() {
      
    }
}

object libroDeHechizos {
    const hechizos = []

    method poderQueAporta(personaje) {
     return if(! hechizos.isEmpty())
      hechizos.first().poderQueAporta(personaje) else 0
    }
    method utilizar() {
        if(! hechizos.isEmpty()) { 
            hechizos.remove(hechizos.first())
        }
    }
    method añadirHechizo(hechizo) {
      hechizos.add(hechizo)
    }
} 
// HECHIZOS
object bendicion {
    method poderQueAporta(personaje) { 
        return 4
    }
}
object invisibilidad {
    method poderQueAporta(personaje){
        return personaje.poderBase()
    }
}
object invocacion { 
    method poderQueAporte(personaje) {
        if(personaje.poseeArtefactoEnMorada()){
            return personaje.artefactoMasPoderosoEnMorada().poderQueAporta(personaje)
        }
        else return 0
    }
}
// ENEMIGOS 
object caterina { 
    const morada = fortalezaDeAcero 
    
    method poderTotal(){
        return 28
    }
    method morada(){
        return morada 
    }
}

object archibaldo {
    const morada = palacioDeMarmol
    method poderTotal(){ 
        return 16
    }
    method morada(){ 
        return morada 
    }
}
object astra { 
    const morada = torreDeMarfil
    method poderTotal(){
        return 14
    }
    method morada(){
        return morada 
    }
}
