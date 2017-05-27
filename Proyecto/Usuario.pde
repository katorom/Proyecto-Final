//clase usuario
public class Usuario {
  //Todos los usuarios del sistema tendrán estos atributos.
  String Nombre; //Es el nombre de la persona, se usa para terminos de claridad y de entendimiento de los usuarios.
  String CardID;  //Es el ID del carnet, nos permite la autenticación del usuario.
  boolean Estado; //Es un booleano que nos permite saber si el usuario esta activo: true (usandouna bici) o inactivo: false (ya ha devuelto la bici)
  String Correo;
  //Se crea un primer constructor del objeto, este constructor se usa para cuando el usuario no se ha registrado

  public Usuario(String Nombre, String CardID, String Correo, MySQL msql) {//usuario no registrado                         
    this.Nombre = Nombre;                                                                                 
    this.CardID = CardID;                                                                                 
    this.Estado = false;   
    this.Correo = Correo;
    msql.execute("INSERT INTO usuarios (Nombre,CardID,Estado,Correo) values ('"+Nombre+"','"+CardID+"',false,'"+Correo+"')");
  }                                                                                                       

  //Se crea un segundo constructor, el cual se usa para un usuario registrado, este constructor solo recibe dos parametros
  public Usuario(String CardID, MySQL msql) {//usuario registrado                                           
    msql.query( "SELECT Nombre,Estado,Correo FROM usuarios WHERE CardID LIKE '"+CardID+"'");                     
    msql.next();                                                                                          
    this.Nombre = msql.getString(1);                                                                      
    this.CardID = CardID;                                                                                 
    this.Estado = msql.getBoolean(2);
    this.Correo = msql.getString(3);
  }  
  void askfBike() {
    int seleccion;
    myPort.clear();
    msql.query( "SELECT COUNT(*) FROM bicicletas WHERE Place = '"+Estacion+"' && User = 'Ninguno'");
    msql.next();

    if (msql.getInt(1) == 0) {
      println("No hay bicicletas disponibles");
    } else {
      msql.query( "SELECT Number, User FROM bicicletas WHERE Place = '"+Estacion+"' && User = 'Ninguno'");
      msql.next();
      seleccion = msql.getInt(1);
      msql.query("UPDATE bicicletas SET User = '"+CardID+"', Place = 'inUse' WHERE Number = "+seleccion+"");
      //myPort.write(seleccion); 
      println("has pedido la bici" + " " + seleccion + " " + Nombre);
      msql.query("UPDATE usuarios SET Estado = true WHERE Nombre = '"+Nombre+"'");
    }
  }
  void returnBike() {
    myPort.clear();
    msql.query("SELECT Number FROM bicicletas WHERE User = '"+CardID+"'");
    msql.next();
    int Numero = msql.getInt(1);
    //myPort.write(Numero);
    msql.query("UPDATE bicicletas SET User = 'Ninguno', Place = '"+Estacion+"' WHERE User = '"+CardID+"'");
    msql.query("UPDATE usuarios SET Estado = false WHERE Nombre = '"+Nombre+"'");
    println("has devuelto la bici"+ " " +Numero+ " " + Nombre);
  }
  void accion() { //Funcion desde donde se llama el metodo pedir bici de usuario
  println("estoy en accion");
    if (this.Estado == false) {
      Pedir.setVisible(true);
      //this.askfBike();
      //mode++;
      delay(2000);
      println("estoy en pedir");
    } else {
      Devolver.setVisible(true);
      println("estoy en devolver");
      //this.returnBike();
      /*String confirm = Dialogo.preguntar("Escribe si o no", "Deseas devolver la bicicleta?");
       if (confirm == "si" || confirm == "Si" || confirm == "SI" || confirm == "sI") {
       elusuario.returnBike();
       } 
       else {
       println("Esta bien, continua usandola");
       }*/
      //mode ++;
    }
  }
}