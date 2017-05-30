public class Estacion {

  String NameStation;
  int id_estacion;
  Boolean State;

  public Estacion(MySQL msql) {

    do {
      this.NameStation = CurrentStation;                                                  
      msql.query("SELECT NombreEstacion, EstadoEstacion, IdEstacion FROM estaciones WHERE (NombreEstacion LIKE '"+this.NameStation+"%')");
      msql.next();
      this.State = msql.getBoolean(2);
    } while (State==true);
    this.State = msql.getBoolean(2);
    this.id_estacion = msql.getInt(3);
    println(this.id_estacion);
    msql.query("UPDATE estaciones SET EstadoEstacion = true WHERE NombreEstacion='"+this.NameStation+"'");
    println("La estacion del dia es: "+" "+this.NameStation);
    //inicio();
  }

  public Estacion(MySQL msql, String NameStation) {

    this.NameStation = NameStation;                                                                            
    msql.query("SELECT NombreEstacion, IdEstacion FROM estaciones WHERE NombreEstacion ='"+this.NameStation+"'");
    msql.next();
    this.id_estacion = msql.getInt(2);
    println("La estacion de destino es: "+" "+this.NameStation);
  }
}