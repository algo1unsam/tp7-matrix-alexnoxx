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
    const precio = 50
    
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

    method precio() = precio //agregado para la tercera parte
}

object paquetito {
    var pago = true

    method esta_pago() = pago
    method puede_ser_entregado(empleado) = true

}



object paqueton{
    var property destinos = #{valentin_alsina, matrix}
    var pagado = 0
    
    method precio() = destinos.size() * 100  // $100 por destino
    
    method pagar(monto) {
        pagado = pagado + monto
    }
    
    method esta_pago() = pagado >= self.precio() //verifico que este pagado en su totalidad
    
    method puede_ser_entregado(empleado) {
        return self.esta_pago() && destinos.all({ destino => destino.puede_llegar(empleado) })
    }

}


//Pruebo agregando un nuevo mensajero y chequear que todo funcione.

object paquete_express {
    var pago = false
    var property lugares = matrix
    const precio = 200  //Mas caro porque es express
    
    method esta_pago() = pago
    method precio() = precio
    
    method pagar() {
        pago = true
    }
    
    //Solo puede ser entregado por mensajeros que pesen menos de 200kg
    method puede_ser_entregado(empleado) {
        return lugares.puede_llegar(empleado) && self.esta_pago() && empleado.peso() < 200
    }
}


object mensajeria {
    var empleados = #{}
    var paquetes_pendientes = []
    var paquetes_enviados = []

    method contratar_empleados(empleado) = empleados.add(empleado)
    method despedir_empleados(empleado) = empleados.remove(empleado)
    method despedir_todos() = empleados.clear()
    method es_grande() = empleados.size() > 2

    //Consultar si un paquete puede ser entregado por el primer empleado de la empresa.
    method puede_entregar_paquete(paquete) = empleados.first().puede_entregar(paquete)
    method peso_ult_empleado() = empleados.last().peso()

    //metodos de la tarcera parte
    method puede_entregar_empresa(paquete) = empleados.any({ empleado => empleado.puede_entregar(paquete) })
    method empleados_que_pueden_entregar(paquete) = empleados.filter({ empleado => empleado.puede_entregar(paquete) })
    method tiene_sobrepeso() = empleados.map({ empleado => empleado.peso() }).average() > 500



    method enviar_paquete(paquete) {//entiendo que trabaja con paquete, no con paquetito o paqueton

        var empleados_disponibles = empleados.find({ empleado => empleado.puede_entregar(paquete) })

        if (empleados_disponibles.isEmpty()) {
            paquetes_pendientes.add(paquete)
        } else {
            paquetes_enviados.add(paquete)
        }
    }


    //Facturacion: Total ganado por los paquetes enviados
    //Entiendo que trabaja con paquete, no con paquetito o paqueton
    method facturacion() = paquetes_enviados.sum({ paquete => paquete.precio() })

    // Dado un conjunto de paquetes, enviarlos a todos.
    method enviar_conjunto_paquetes(lista_paquetes) { //Voy a estar obligado a crear una lista: lista_paquetes = [paquete, paquetito, paqueton]
        lista_paquetes.forEach({ paquete => self.enviar_paquete(paquete) })
    }

    //Enviar paquete mas caro pendiente
    method enviar_paquete_mas_caro() {
        if (!paquetes_pendientes.isEmpty()) {
            var paquete_mas_caro = paquetes_pendientes.max({ paquete => paquete.precio() })
            self.enviar_paquete(paquete_mas_caro)
            paquetes_pendientes.remove(paquete_mas_caro)
            paquetes_enviados.add(paquete_mas_caro)
        }
    }

    method paquetes_pendientes() = paquetes_pendientes
    method paquetes_enviados() = paquetes_enviados

}   

    