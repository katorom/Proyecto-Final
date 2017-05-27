import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;
import g4p_controls.*;
import java.awt.*;


MySQL msql; // se declara el objetos SQL
Serial myPort; //se declara el objeto serial
Usuario elusuario; //Se crea una variable de tipo usuario.
Bicicleta bici;

PImage bg;
//Varialbles necesarias para el constructor del objeto SQL
String user     = "root2";
String pass     = "";
String database = "proyectopoo";
int mode = 0; //Variable para hacer el switch
String Estacion = "Calle 26";
String ta;
//String counter = " "; //Variable para ue la funcion pedir bici se ejecute solo una vez 

void setup() {
  size(1000, 947);
  bg = loadImage("bicirrun.jpg");
  createGUI();
  String portName = Serial.list()[0]; //Se selecciona el puerto serie de ARDUINO
  myPort = new Serial(this, portName, 9600); //Se crea el objeto tipo Serie
  msql = new MySQL( this, "192.168.43.31", database, user, pass ); // Se crea el objeto tipo SQL
  println("estoy antes del if");
  if ( msql.connect() ) {
    println("estoy en el if");
    /*inicio();
    println("ya ejecute inicio");*/
  }//Primero se verifica si se esta conectado a la base de datos SQL
  else {
    println("failed connection");//Si no, se imprime un mensaje.
    while (true);
  }
  inicio();
  println("ya ejecute inicio");
  //in ();
}

void draw() {
  background(bg);
  
  //Registro();
  //background(255);
  //in();
  
  
  /*switch(mode) {
   
   case 0: 
   Registro();
   mode = -1;
   break;
   
   case 1:
   elusuario.accion();
   mode = 0;
   break;
   default:break;
   }*/
}

void inicio () {
  Inicio.setVisible(true);
  sig.setVisible(true);
  email.setVisible(false);
  nombre.setVisible(false);  
  registrar.setVisible(false); 
  nom.setVisible(false); 
  corr.setVisible(false);
  Pedir.setVisible(false); 
  Devolver.setVisible(false);
  Inicio.setFont(new Font("Times New Roman", Font.PLAIN, 35));
  email.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  nombre.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  registrar.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  nom.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  corr.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  sig.setFont(new Font("Times New Roman", Font.PLAIN, 30));
  Pedir.setFont(new Font("Times New Roman", Font.PLAIN, 25)); 
  Devolver.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  //delay(1000);
  
}

/*void in (){
  String id; // se declara una variable id, para usarla para poder saber si se ha leido una tarjeta
  myPort.clear(); //Se limpia el puerto serial.  
  while (true) { // el ciclo while se ejecutara hasta que la persona acerque su carnet.
    //id = cardID(); 
    //inicio();
    if (cardID() != null) {
      break;
    } 
    delay(1000); //para corregir errores de envio del ID del carnet se agrega un delay
    Registro();
  }
}*/

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

void keyPressed() {//Metodo temporal para alternar el menu

  if (key == ' ') {

    if (mode == -1) {
      mode = 1;
    }
  }   //mode = mode < 1 ? mode+1 : 0;
}

void Registro() {

  String id; // se declara una variable id, para usarla para poder saber si se ha leido una tarjeta
  myPort.clear(); //Se limpia el puerto serial.  
  while (true) { // el ciclo while se ejecutara hasta que la persona acerque su carnet.
    id = cardID(); 
    //inicio();
    if (id != null) {
      break;
    } 
    delay(1000); //para corregir errores de envio del ID del carnet se agrega un delay
  }
  
  //String id = cardID();
  msql.query( "SELECT COUNT(*) FROM usuarios WHERE CardID LIKE '"+id+"'"); //Se realiza la busqueda del ID dentro de la base de datos
  msql.next();

  if (msql.getInt(1) == 0) {
    ta=id;
    Inicio.setVisible(false);
    sig.setVisible(false);
    email.setVisible(true);
    nombre.setVisible(true);  
    registrar.setVisible(true); 
    nom.setVisible(true); 
    corr.setVisible(true);
    println("no te reconozco");
  } else { 
    elusuario = new Usuario(id, msql); 
    println("Bienvenido" +" "+elusuario.Nombre);
    Inicio.setVisible(false);
    sig.setVisible(false);
    elusuario.accion();
  }
  //println("this table has " + msql.getString(1) + " number of rows" );
}