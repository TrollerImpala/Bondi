class Bondi{
  var Pasajeros_Paradas_Ida = [0]
  var Pasajeros_Paradas_Vuelta = [0]
  
  const Paradas
  const Max_Pasajeros
  
  var property Combustible = 0
  var property Pasajeros = 0
  var property Parada = 0
  var IdaVuelta = 0
  
  
  
  // ------Metodos de uso publico------
  /* Resetea el viaje, carga combustible, y llena la lista
  de ida con numeros aleatorios
  */
  method Comenzar(){
    self.Recargar_Combustible()
    Pasajeros_Paradas_Ida = [0]
    Pasajeros_Paradas_Vuelta = [0]
    
    self.Llenar_Lista(Paradas) 
    
    Parada = 0
    Pasajeros = 0
    IdaVuelta = 0
  }
  
  
  // Avanza una parada y recoge a los pasajeros de la misma
  method Avanzar(){
    self.Avanzar_Personalizado(1)
    
    if (Parada > 0 && Parada < Paradas){
      if (IdaVuelta == 0){
        //self.Subir_Pasajeros(Pasajeros_Paradas_Ida.get(Parada))
        self.Subir_Pasajeros(Pasajeros_Paradas_Ida.get(1))
      }
      
      if (IdaVuelta == 1){
        //self.Subir_Pasajeros(Pasajeros_Paradas_Vuelta.get(Parada))
        self.Subir_Pasajeros(Pasajeros_Paradas_Vuelta.get(1))
      }
      
    }
  }
  
  
  /* Avanza hasta la ultima parada de ida o de vuelta /
  repite el avanzar la cantidad de veces necesarias
  para llegar a la terminal
  */
  method Avanzar_final(){
    IdaVuelta = self.IdaOVuelta()
    Pasajeros = 0
       
    if (IdaVuelta == 0) {
      var C_Paradas = (Parada - Paradas) * -1
      C_Paradas.times( { n => self.Avanzar() } )
      //return self.Avanzar_Personalizado(C_Paradas)
    }
    
    if (IdaVuelta == 1) { 
      var C_Paradas = Paradas - (Paradas - Parada)
      
      C_Paradas.times( { n => self.Avanzar() } )
      //return self.Avanzar_Personalizado(C_Paradas)
    }
    
  }
    
    /*
    lol nada xd el error era boludo
    */
  
  
  // Recarga el combustible del colectivo
  method Recargar_Combustible(){
    if (Parada == 0 || Parada == Paradas){
        Combustible = 2*Paradas
    }
    else { return 'No se puede recargar aca' }
  }
  
  /* Agrega una cantidad dicha por el usuario de pasajeros a
  la lista de ida o vuelta
  */
  method Agregar_A_Lista(num){
    if (num < 0){
      return 'No se pueden agregar numeros negativos'
    }
    
    if (Pasajeros_Paradas_Ida.size() == Paradas || Pasajeros_Paradas_Vuelta.size() == Paradas){
      return 'No se pueden agregar más personas en las paradas'
    }
    else{
    
      if (IdaVuelta == 0){
        Pasajeros_Paradas_Ida = Pasajeros_Paradas_Ida + [num]
      }
    
      if (IdaVuelta == 1){
      
        Pasajeros_Paradas_Vuelta = Pasajeros_Paradas_Vuelta + [num]
      }
    }
  }    
  
    /* Agrega una coleccion de pasajeros a la coleccion de ida o vuelta de pasajeros */
    method Llenar_Lista_Personalizado(coleccion){

        coleccion.forEach( { n => 
          
          
          
          if (n > 0){
            var Pasajeros_aux = Pasajeros_Paradas_Ida + [n]
        
      
        
        
            if (Pasajeros_aux.size() > Paradas){
              return 'No se pueden agregar más personas en las paradas'
            }
            else{
    
              if (IdaVuelta == 0){
                Pasajeros_Paradas_Ida = Pasajeros_aux
              }
    
              if (IdaVuelta == 1){
      
                Pasajeros_Paradas_Vuelta = Pasajeros_aux
              }
            }
          
          } 
          
          
          
          } )
          
      
        
  }    



  // ------Metodos de uso privado------
  
  
  // Agrega un valor a la lista de pasajeros de Ida
  method Pas_Par(){
    Pasajeros_Paradas_Ida = Pasajeros_Paradas_Ida + [0.randomUpTo(4).roundUp()]
  }
  
  // Llena la lista de Ida con valores
  method Llenar_Lista(paradas){
    //var paradas_m_uno = paradas - 1
    
    var paradas_m_uno = paradas - Pasajeros_Paradas_Ida.size()
    
    /*
      if (Pasajeros_Paradas_Ida.size() == Paradas || Pasajeros_Paradas_Vuelta.size() == Paradas){
      return 'Nada que llenar'
    }
    */
    paradas_m_uno.times( { n => self.Pas_Par() } )
    
    Pasajeros_Paradas_Ida = Pasajeros_Paradas_Ida + [0]
  }
  
  // Verifica si no se pueden subir más pasajeros
  method SePasaPasajeros(C_Pasajeros){
    if(Pasajeros + C_Pasajeros > Max_Pasajeros){
      return true
    }
    else {
      return false
    }
  }
  
  // Sube a la cantidad de pasajeros de la parada al colectivo
  method Subir_Pasajeros(C_Pasajeros){
    if ( self.SePasaPasajeros(C_Pasajeros) ){
      
      var No_Subidos = (Pasajeros + C_Pasajeros) - Max_Pasajeros
      
      Pasajeros = Max_Pasajeros
      
      if (IdaVuelta == 0){
        
        
        Pasajeros_Paradas_Ida.remove(Pasajeros_Paradas_Ida.get(1))
        
        Pasajeros_Paradas_Vuelta = Pasajeros_Paradas_Vuelta + [No_Subidos]
      }
      
      if (IdaVuelta == 1){
        
        Pasajeros_Paradas_Vuelta.remove(Pasajeros_Paradas_Vuelta.get(1))
        
        
        Pasajeros_Paradas_Ida = Pasajeros_Paradas_Ida + [No_Subidos]
      }
    }
    else{
      
      Pasajeros += C_Pasajeros
      
      if (IdaVuelta == 0){
        
        Pasajeros_Paradas_Vuelta = Pasajeros_Paradas_Vuelta + [0]
        
        //Pasajeros_Paradas_Ida.remove(Pasajeros_Paradas_Ida.get(Parada))
        Pasajeros_Paradas_Ida.remove(Pasajeros_Paradas_Ida.get(1))
      }
      
      
      if (IdaVuelta == 1){
      
        Pasajeros_Paradas_Ida = Pasajeros_Paradas_Ida + [0]
        
        //Pasajeros_Paradas_Vuelta.remove(Pasajeros_Paradas_Vuelta.get(Parada))
        Pasajeros_Paradas_Vuelta.remove(Pasajeros_Paradas_Vuelta.get(1))
      }
    }
  }
  
  // Verifica si el colectivo esta de ida o vuelta
  method IdaOVuelta(){
    if (Parada == Paradas) {
      Pasajeros = 0
      return 1
    }
    
    if (Parada == 0) {
      Pasajeros = 0
      return 0
    }
    else { return IdaVuelta }
    
    
  }
  
  /* Verifica si no hay suficiente combustible para realizar
  el recorrido
  */
  method SePasa(C_Paradas){
    
    if (self.Uso_Combustible(C_Paradas) < 0 ){
      return true
    }
    
    if (IdaVuelta == 0){
      
      if (Parada + C_Paradas > Paradas ){
        return true
      }
      else { return false }
    }
    
    if (IdaVuelta == 1){
      if (Parada - C_Paradas < 0 ){
        return true
      }
      else { return false }
    }
    
  }
  
  
  // Resta al combustible lo que se usa
  method Uso_Combustible(C_Paradas){

    return Combustible - (C_Paradas + (0.1 * Pasajeros))
    
  }
  
  /* Metodo hecho para avanzar la cantidad que se quiera
  de paradas
  */
  method Avanzar_Personalizado(C_Paradas){
    IdaVuelta = self.IdaOVuelta()
    
    // --- Agregar al principio de este metodo como suben los pasajeros
    
    if (self.SePasa(C_Paradas)){
      return 'No tiene suficiente combustible'
    }
    else{
      
      Combustible = self.Uso_Combustible(C_Paradas)
      //Combustible - (C_Paradas + (0.1 * Pasajeros))
      
      if (IdaVuelta == 0) {
        Parada += C_Paradas
      }
      
      if (IdaVuelta == 1) {
        Parada -= C_Paradas
      }
      
      // return 'Ha llegado a su parada, use <Subir_Pasajeros(X)> para subir los pasajeros de esta parada.'
      
      return 'Ha llegado a su parada.'
    }
    
     
    
  }
  
  
  
  
}