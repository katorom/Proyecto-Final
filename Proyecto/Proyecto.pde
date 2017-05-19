import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;
import controlP5.*;

MySQL msql; // se declara el objetos SQL
Serial myPort; //se declara el objeto serial
ControlP5 cp5;
Usuario elusuario; //Se crea una variable de tipo usuario.

//Varialbles necesarias para el constructor del objeto SQL
String user     = "root";
String pass     = "";
String database = "proyectopoo";
float n,n1;

void setup() {
  size(500, 500);
  noStroke();
  cp5 = new ControlP5(this);
  
  PFont font = createFont("arial",20);
  
  //Se crea un boton llamado registrarse
  cp5.addButton("Registrarse")
     .setValue(0)
     .setPosition(width/2,height/2)
     .setSize(100,100)
     ;
     
   cp5.addTextfield("input")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
 
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  msql = new MySQL( this, "localhost", database, user, pass );
  if ( msql.connect() ){}//Primero se verifica si se esta conectado a la base de datos SQL
  else{
      println("failed connection");//Si no, se imprime un mensaje.
      while(true);
  }
  textFont(font);
}
  
void draw(){
  background(0);
  n += (1-n)* 0.1;  
  fill(255);
  text(cp5.get(Textfield.class,"input").getText(), 360,130);
  myPort.clear(); //Se limpia el puerto serial.
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}
public String input(String theText) {
  // automatically receives results from controller input
  return(theText);
}
  
String cardID() { // metodo para leer el ID del carnet
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

String nombre() {// metodo para obtener el nombre de la persona
  String str = Dialogo.preguntar("Nombre", "Ingrese su nombre");
  return(str);
}
public void Registrarse(){
  
  String id; // se declara una variable id, para usarla para poder saber si se ha leido una tarjeta
  
  while(true){ // el ciclo while se ejecutara hasta que la persona acerque su carnet.
    id = cardID(); 
    if(id != null){break;} 
    delay(1000); //para corregir errores de envio del ID del carnet se agrega un delay
  }
  
  msql.query( "SELECT COUNT(*) FROM usuarios WHERE CardID LIKE '"+id+"'"); //Se realiza la busqueda del ID dentro de la base de datos
  msql.next();
  
  if(msql.getInt(1) == 0){
    elusuario = new Usuario(nombre(),id,msql); 
  }else{ 
    elusuario = new Usuario(id,msql); 
    println("el usuario" +" "+elusuario.Nombre+" "+ "ya se encuentra registrado ");
  }
  //println("this table has " + msql.getString(1) + " number of rows" );
}