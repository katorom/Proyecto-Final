public class Bicicleta {

  int Number;
  boolean Disponibilidad; 

  public Bicicleta(MySQL msql) {     
    println(this.Number);
    if(elusuario.Estado==false){
      msql.query("SELECT IdBicicleta FROM `estaciones`,`estación-bicicletas`,`bicicletas` WHERE (`estaciones`.`NombreEstacion`='"+CurrentStation+"') AND (`estación-bicicletas`.`IdEstacion` = `estaciones`.`IdEstacion`) AND (`estación-bicicletas`.`IdBicicletas`=`bicicletas`.`IdBicicleta`) AND (EstadoBicicleta=false)");
      println(this.Number);
      msql.next();
    }else{
      msql.query("SELECT IdBicicleta FROM `prestamos` WHERE CardID LIKE '"+elusuario.CardID+"%'");
      println(this.Number);
      msql.next();
      println();
    }
    println(this.Number);
    this.Number = msql.getInt(1);
    println(this.Number);
  }

  void assignBike(String Llegada) {
    println(this.Number);
    myPort.clear();
    //String Llegada = Dialogo.preguntar("Estacion", "¿Hacía dónde vas?");
    station = new Estacion (msql, Llegada);
    msql.execute("INSERT INTO prestamos (CardID,IdBicicleta,IdEstacionSalida,IdEstacionLlegada) values ('"+elusuario.CardID+"\r\n',"+this.Number+","+IdCurrentStation+","+station.id_estacion+")");
    //msql.next();
    println("Has pedido la bici "+this.Number+" Sr@ "+elusuario.Nombre);
    msql.query("UPDATE usuarios SET EstadoUsuario = true WHERE CardIDUsuario LIKE '"+elusuario.CardID+"%'");
    //msql.next();
    msql.query("UPDATE bicicletas SET EstadoBicicleta = true WHERE IdBicicleta = "+this.Number+"");
    //msql.next();
    msql.query("DELETE FROM `estación-bicicletas` WHERE `IdEstacion`="+IdCurrentStation+" AND `IdBicicletas`="+this.Number+"");
    //msql.next();
  }

  void returnBike() {
    myPort.clear();
    msql.query("SELECT IdBicicleta FROM prestamos WHERE CardID LIKE '"+elusuario.CardID+"%'");
    msql.next();
    this.Number = msql.getInt(1);
    println(this.Number);
    //myPort.write(Numero); motores
    msql.query("UPDATE prestamos SET HoraSalida = HoraSalida, HoraLlegada = CURRENT_TIMESTAMP WHERE CardID LIKE '"+elusuario.CardID+"%'");
    //msql.next();
    msql.query("SELECT TIMESTAMPDIFF(MINUTE, HoraSalida, HoraLlegada) FROM prestamos WHERE CardID LIKE '"+elusuario.CardID+"%'");
    msql.next();
    int Demora = (msql.getInt(1))-15;
    int Valor = Demora*200;
    msql.query("UPDATE bicicletas SET EstadoBicicleta = false WHERE IdBicicleta="+this.Number+"");
    //msql.next();
    msql.execute("INSERT INTO `estación-bicicletas`(`IdEstacion`, `IdBicicletas`) VALUES ("+IdCurrentStation+","+this.Number+")");
    //msql.next();
    msql.query("UPDATE usuarios SET EstadoUsuario = false WHERE CardIDUsuario LIKE '"+elusuario.CardID+"%'");
    //msql.next();
    println("Has devuelto la bicicleta");
    if (Demora > 0) {
      msql.execute("INSERT INTO deudores (CardIDUsuario, TiempoExcedido, ValorMulta) values('"+elusuario.CardID+"\r\n',"+Demora+","+Valor+") ");
      //msql.next();
      msql.query("DELETE FROM prestamos WHERE CardID LIKE '"+elusuario.CardID+"%'");
      //msql.next();
      println("Usted se ha demorado "+Demora+" minutos de más, por lo tanto debe pagar una multa de: "+Valor+" para poder seguir usando el sistema.");
    }
    msql.query("DELETE FROM prestamos WHERE CardID LIKE '"+elusuario.CardID+"%'");
    //msql.next();
  }
}