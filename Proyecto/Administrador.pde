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
    println("AQUIIIII ESTAAAAAAAA EL NUMERO DE BICIIIIIIIIIIIIIIS A AÑADIR "+addBicis);
    msql.query("SELECT IdEstacion FROM `estaciones` WHERE NombreEstacion = '"+addEstacion+"'");
    msql.next();
    int addStat = msql.getInt(1);
    for(int i=0;i<addBicis;i++){
      println("parametro para CICLOOOO "+i+"-----------"+addBicis);
      msql.query("INSERT INTO `bicicletas` (`IdBicicleta`, `EstadoBicicleta`) VALUES (NULL, '0')");
      msql.query("SELECT IdBicicleta FROM `bicicletas` ORDER BY IdBicicleta DESC");
      msql.next();
      println(msql.getInt(1));
      msql.query("INSERT INTO `estación-bicicletas` (`IdEstacion`, `IdBicicletas`) VALUES ("+addStat+","+msql.getInt(1)+")");
    }
  }
  
  void deleteBikes(){
  inadm ();
  }
  
  void addStation(){
  inadm ();
  }
  void deleteStation(){
  inadm ();
  }
  
  void accion(){
    inadm ();
  }
}