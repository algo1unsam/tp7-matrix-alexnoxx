import mensajeria.*

//empleados

object morfeo {

    var property transporte = nabucodonosor    //transporte que usa el tipo
    var peso_morfeo = 90 //inicializo en 0

    method peso() = peso_morfeo + transporte.peso()

    method puedeLlamar() = false //sino tiene dinero no puede llamar

    
    method puede_entregar() = paquete.lugares().puede_llegar(self) //puede_llegar() esta relacionado con si puede entregar en ese lugar
      
    
}

object trinity {
    const property peso = 900

    method puedeLlamar() = true

    method puede_entregar() = paquete.lugares().puede_llegar(self)

}

object neo {

    const peso_neo = 0
    var property tiene_credito = false

    method peso() = peso_neo
    method puedeLlamar() = tiene_credito

    method puede_entregar() = paquete.lugares().puede_llegar(self)
}



//transportes

object monopatin {

    method peso() = 1
}

object nabucodonosor {
    var peso_acoplado = 500 //peso del acoplado: media tonelada
    var property cantidad_acoplados = 1 //cantidad de acoplados

    method peso() = peso_acoplado * self.cantidad_acoplados()
}




//**/
//object puente {
//}

