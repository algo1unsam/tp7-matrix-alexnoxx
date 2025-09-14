import empleados_m.*




//destinos
object valentin_alsina {
    method puede_llegar(empleado) = empleado.peso()<1000
}

object matrix {
    method puede_llegar(empleado) = empleado.puedeLlamar()
}



//**//
object paquete {
    var pago = false
    var property lugares = valentin_alsina
    
    method esta_pago() = pago
    //method lugares(lugar){
    //    lugares = lugar
    //}

    method pagar() {
        pago = true
    } 
    
    method puede_ser_entregado(empleado){
        return lugares.puede_llegar(empleado) && self.esta_pago() //ver si no es redundante

    }
}


object mensajeria {
    var empleados = #{}

    method contratar_empleados(empleado) = empleados.add(empleado)
    method despedir_empleados(empleado) = empleados.remove(empleado)
    method despedir_todos() = empleados.clear()
    method es_grande() = empleados.size() > 2

    //Consultar si un paquete puede ser entregado por el primer empleado de la empresa.
    method puede_entregar_paquete(paquete) = empleados.first().puede_entregar(paquete)
    method peso_ult_empleado() = empleados.last().peso()
}   