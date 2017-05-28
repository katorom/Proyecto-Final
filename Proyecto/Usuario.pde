//clase usuario
public class Usuario {
  //Todos los usuarios del sistema tendrán estos atributos.
  String Nombre; //Es el nombre de la persona, se usa para terminos de claridad y de entendimiento de los usuarios.
  String CardID;  //Es el ID del carnet, nos permite la autenticación del usuario.
  boolean Estado; //Es un booleano que nos permite saber si el usuario esta activo: true (usandouna bici) o inactivo: false (ya ha devuelto la bici)
  String Correo;  //Correo del usuario
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
    //Primero se verifica si hay bicicletas disponibles en la estación 
    myPort.clear();
    msql.query( "SELECT COUNT(*) FROM bicicletas WHERE Place = '"+Estacion+"' && User = 'Ninguno'");
    msql.next();

    if (msql.getInt(1) == 0) {
      println("No hay bicicletas disponibles");
    } else {
      bici = new Bicicleta(Estacion, this, msql); //Se instancia una bicicleta, que será asignada al usuario
      bici.out(); //Llama metodo de bicicleta para asignarla al usuario en la base de datos
    }
  }
  void returnBike() {
    bici = new Bicicleta(Estacion, this, msql);//Se intancia una bicicleta ya asignada al usuario
    bici.in (); //Llama método de bicicleta para quitar la asignación al usuario en la base de datos
  }
  void accion() { //Metodo desde donde se decide si el usuario puede pedir bicicleta o tiene que devolver
    Inicio.setVisible(false);
    sig.setVisible(false);
    println("estoy en accion");
    if (this.Estado == false) {//Si el usuario no tiene bici prestada, va a pantalla de pedir bici
      Pedir.setVisible(true);
      println("estoy en pedir");
    } else {
      Devolver.setVisible(true); //Si el usuario tiene bici prestada va a pantalla de devolver bici
      println("estoy en devolver");
    }
  }
}