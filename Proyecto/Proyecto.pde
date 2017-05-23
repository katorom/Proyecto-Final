import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;

MySQL msql; // se declara el objetos SQL
Serial myPort; //se declara el objeto serial
Usuario elusuario; //Se crea una variable de tipo usuario.

//Varialbles necesarias para el constructor del objeto SQL
String user     = "root";
String pass     = "";
String database = "proyectopoo";
int mode = 0; //Variable para hacer el switch
//int counter = 0; //Variable para ue la funcion pedir bici se ejecute solo una vez 
String cod = " ";//Cambio variable para ue la funcion pedir bici se ejecute solo una vez

void setup() {

  size(500, 500);
  String portName = Serial.list()[1]; //Se selecciona el puerto serie de ARDUINO
  myPort = new Serial(this, portName, 9600); //Se crea el objeto tipo Serie
  msql = new MySQL( this, "localhost", database, user, pass ); // Se crea el objeto tipo SQL
  if ( msql.connect() ) {
  }//Primero se verifica si se esta conectado a la base de datos SQL
  else {
    println("failed connection");//Si no, se imprime un mensaje.
    while (true);
  }
}

void draw() {
  background(0);
  switch(mode) {
    
  case 0: 
    Registro();
    //println(mode);
    break;

  case 1:
    //println(mode);
    accion();
    break;
  }
}

String cardID() { // metodo para leer el ID del carnet
  while (myPort.available() > 0) { //Mientras haya un puerto serial conectado
    String inBuffer = myPort.readString();   //En esta variable se guarda el ID del carnet enviado por ARDUINO
    if (inBuffer != null) 
      return(inBuffer);
    else {
      return("vacio");
    }
  }
  return(null);
}

String nombre() {// metodo para obtener el nombre de la persona
  String str = Dialogo.preguntar("Nombre", "Ingrese su nombre");
  return(str);
}

void keyPressed() {//Metodo temporal para alternar el menu

  if (key == ' ') {

    if (mode < 1) {
      mode++;
    } else {
      mode = 0;
    }
  }   //mode = mode < 1 ? mode+1 : 0;
}

void accion() { //Funciopn desde donde se llama el metodo pedir bici de usuario
  while (cod != elusuario.CardID) {
    elusuario.askfBike();
    println("estoy en accion");
    cod = elusuario.CardID;
  }
  
}

void Registro() {

  String id; // se declara una variable id, para usarla para poder saber si se ha leido una tarjeta
  myPort.clear(); //Se limpia el puerto serial.
  while (true) { // el ciclo while se ejecutara hasta que la persona acerque su carnet.
    id = cardID(); 
    if (id != null) {
      break;
    } 
    delay(1000); //para corregir errores de envio del ID del carnet se agrega un delay
  }
  msql.query( "SELECT COUNT(*) FROM usuarios WHERE CardID LIKE '"+id+"'"); //Se realiza la busqueda del ID dentro de la base de datos
  msql.next();

  if (msql.getInt(1) == 0) {
    elusuario = new Usuario(nombre(), id, msql);
  } else { 
    elusuario = new Usuario(id, msql); 
    println("Bienvenido" +" "+elusuario.Nombre);
  }
  //println("this table has " + msql.getString(1) + " number of rows" );
}