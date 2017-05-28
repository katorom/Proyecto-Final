import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;
import g4p_controls.*;
import java.awt.*;


MySQL msql; // se declara el objetos SQL
Serial myPort; //se declara el objeto serial
Usuario elusuario; //Se crea una variable de tipo usuario.
Bicicleta bici;

PImage bg; //Variable de imagen para fondo
//Varialbles necesarias para el constructor del objeto SQL
String user     = "root2";
String pass     = "";
String database = "proyectopoo";
int mode = 0; //Variable para hacer el switch
String Estacion = "Calle 26";
String idreg;

void setup() {
  size(845, 800);
  bg = loadImage("bicirrun2.jpg"); //Se carga imagen para el fondo 
  createGUI();   //Funcion de la interfaz gráfica, autogenerada
  String portName = Serial.list()[0];   //Se selecciona el puerto serie de ARDUINO
  myPort = new Serial(this, portName, 9600);     //Se crea el objeto tipo Serie
  msql = new MySQL( this, "192.168.43.31", database, user, pass );   // Se crea el objeto tipo SQL
  if ( msql.connect() ) {
  }//Primero se verifica si se esta conectado a la base de datos SQL
  else {
    println("failed connection");//Si no, se imprime un mensaje.
    while (true);
  }
  letra();
  inicio();
}

void draw() {
  background(bg);
}

//Configuración de la pantalla de inicio
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
  NumBici.setVisible(false);
  entendido.setVisible(false);
}

//Controla el tipo de la letra y el tamaño de la letra, solo se ejecuta una vez
void letra (){
  Inicio.setFont(new Font("Times New Roman", Font.PLAIN, 35));
  email.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  nombre.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  registrar.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  nom.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  corr.setFont(new Font("Times New Roman", Font.PLAIN, 25));
  sig.setFont(new Font("Times New Roman", Font.PLAIN, 30));
  Pedir.setFont(new Font("Times New Roman", Font.PLAIN, 25)); 
  Devolver.setFont(new Font("Times New Roman", Font.PLAIN, 25));  
  NumBici.setFont(new Font("Times New Roman", Font.PLAIN, 25));  
  entendido.setFont(new Font("Times New Roman", Font.PLAIN, 25));
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
    idreg=id;
    //Mediante el metodo de G4P, se cambia la visibilidad de los objetos para mostrar la pantalla de registro
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
    elusuario.accion(); //Se llama metodo accion de usuario en el que se comprobuea si el usuario tiene o no bici prestada
  }
}