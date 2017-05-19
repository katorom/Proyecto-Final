import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;

MySQL msql;
Serial myPort;

String user     = "root";
String pass     = "";
String database = "proyectopoo";

Usuario elusuario;

void setup() {
  size(500, 500);
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  msql = new MySQL( this, "localhost", database, user, pass );
  if ( msql.connect() ){}
  else
  {
      println("failed connection");
      while(true);
  }
}
void draw(){
  String id;
  while(true){
    id = cardID();
    if(id != null){break;}
    delay(1000);
  }
  msql.query( "SELECT COUNT(*) FROM usuarios WHERE CardID LIKE '"+id+"'");
  msql.next();
  if(msql.getInt(1) == 0){//no registrado
    elusuario = new Usuario(nombre(),id,msql);
  }else{//registrado
    elusuario = new Usuario(id,msql);
    println("el nombre es "+elusuario.Nombre);
  }
  println("this table has " + msql.getString(1) + " number of rows" );
}
//elusuario.pedirBici();

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