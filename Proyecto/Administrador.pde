private class Administrador extends User{
  String Nombre;
  String Password;
  String CardID;
  String Correo;
  
  public Administrador(MySQL msql, String user, String password){
     this.Nombre = user;
     this.Password = password;
  } 
  
  /*String setPlace(){
  
  }*/
  
  void addBikes(int addBicis, String addEstacion){
    msql.query("SELECT IdEstacion FROM `estaciones` WHERE NombreEstacion = '"+addEstacion+"'");
    msql.next();
    int addStat = msql.getInt(1);
    for(int i=0;i<addBicis;i++){
      msql.query("INSERT INTO `bicicletas` (`IdBicicleta`, `EstadoBicicleta`) VALUES (NULL, '0')");
      msql.query("SELECT IdBicicleta FROM `bicicletas` ORDER BY IdBicicleta DESC");
      msql.next();
      msql.query("INSERT INTO `estación-bicicletas` (`IdEstacion`, `IdBicicletas`) VALUES ("+addStat+","+msql.getInt(1)+")");
    }
  }
  
  void deleteBikes(int idbici){
   // msql.query("DELETE FROM estación-bicicletas WHERE IdBicicletas = "+idbici+""); //Se realiza la busqueda del ID dentro de la base de datos
   // msql.query("DELETE FROM bicicletas WHERE IdBicicleta = "+idbici+"");
  }
  
  void addStation(String Nombre){
  }
  
  void deleteStation(String Estacion){
  
  }
   
   //La funcion que faltaba
  public int eliminarMultas (String CardID){
    msql.query( "SELECT ValorMulta FROM deudores WHERE CardIDUsuario LIKE '"+CardID+"%'"); //Se realiza la busqueda del ID dentro de la base de datos
    msql.next();
    int valormulta = msql.getInt(1);
    return valormulta;
  }
  
  void accion(){//NO SE QUE HACE ESTA FUNCION
    inadm ();
  }
}