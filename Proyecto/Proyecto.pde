import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;
MySQL msql;

Serial myPort; 
void setup() {
  size(500, 500);
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
}
void draw(){
  noLoop();
  String user     = "root";
  String pass     = "";
  String database = "proyectopoo";
  msql = new MySQL( this, "localhost", database, user, pass );
  
  if ( msql.connect() )
  {
      //msql.query( "SELECT Nombre FROM usuarios WHERE CardID != '107AFF73'");
      //msql.next();
      //println( "this table has " + msql.getString(1) + " number of rows" );
      msql.execute("INSERT INTO usuarios (Nombre,CardID,Estado) values ('"+nombre()+"','"+cardID()+"',false)");
  }
  else
  {
      println("failed connection");
  }
}
String cardID() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();   
    if (inBuffer != null)
      return(inBuffer);
    else{
      return("vacio");
    }  
  }
  return(null);
}

String nombre() {
  String str = Dialogo.preguntar("Demostración #3", "Como te llamas ?");
  return(str);
}