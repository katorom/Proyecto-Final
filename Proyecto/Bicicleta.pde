public class Bicicleta {
  int Number;
  String User; 
  String Lugar; 

  public Bicicleta(String Estacion, Usuario elusuario, MySQL msql) {
    this.User = elusuario.CardID; 
    this.Lugar = Estacion;
  }

  //Método para quitar la bicicleta de "disponibles" y asignar a un usuario en la base de datos
  void out () { 
    msql.query( "SELECT Number, User FROM bicicletas WHERE Place = '"+Estacion+"' && User = 'Ninguno'");
    msql.next();
    Number = msql.getInt(1);
    msql.query("UPDATE bicicletas SET User = '"+ User +"', Place = 'inUse' WHERE Number = "+Number+"");
    //myPort.write(seleccion); 
    println("has pedido la bici" + " " + Number + " " + elusuario.Nombre);
    msql.query("UPDATE usuarios SET Estado = true WHERE Nombre = '"+elusuario.Nombre+"'");
  }

  //Método para poner la bicileta en "disponibles" y quitarle la asignación al usuario en la base de datos
  void in () {
    myPort.clear();
    msql.query("SELECT Number FROM bicicletas WHERE User = '"+User+"'");
    msql.next();
    Number = msql.getInt(1);

    //myPort.write(Numero);
    msql.query("UPDATE bicicletas SET User = 'Ninguno', Place = '"+Estacion+"' WHERE User = '"+User+"'");
    msql.query("UPDATE usuarios SET Estado = false WHERE Nombre = '"+elusuario.Nombre+"'");
    println("has devuelto la bici"+ " " +Number+ " " + elusuario.Nombre);
  }
}