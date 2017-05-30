import co.jimezam.util.Dialogo;
import processing.serial.*;
import de.bezier.data.sql.*;
import g4p_controls.*;
import java.awt.*;


MySQL msql; // se declara el objetos SQL
Serial myPort; //se declara el objeto serial
Usuario elusuario; //Se crea una variable de tipo usuario.
Bicicleta bici;
Estacion station;

//Varialbles necesarias para el constructor del objeto SQL
String user     = "root";
String pass     = "";
String database = "proyectopoo";
String ListaEstacionesO;
String ListaEstacionesD;
String CurrentStation;
int IdCurrentStation;
String idreg;
PImage bg; //Variable de imagen para fondo
String ListaO [];
String ListaD [];
void setup() {
  size(845, 800);
  bg = loadImage("bicirrun2.jpg"); //Se carga imagen para el fondo 
  createGUI(); //Funcion de la interfaz gráfica, autogenerada
  customGUI();
  String portName = Serial.list()[1]; //Se selecciona el puerto serie de ARDUINO
  myPort = new Serial(this, portName, 9600); //Se crea el objeto tipo Serie
  msql = new MySQL( this, "localhost", database, user, pass ); // Se crea el objeto tipo SQL
  if (msql.connect()) {
  }//Primero se verifica si se esta conectado a la base de datos SQL
  else {
    println("failed connection");//Si no, se imprime un mensaje.
    while (true);
  }
  in();
  //station = new Estacion(msql);
  //CurrentStation = station.NameStation;
  //IdCurrentStation = station.id_estacion;
}

void draw() {
  background(bg);
  /*switch(mode) {
   
   case 0: 
   //Registro();
   mode = -1;
   break;
   
   case 1:
   elusuario.accion();
   mode = 0;
   break;
   default:
   break;
   }*/
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

/*void keyPressed() {//Metodo temporal para alternar el menu
 
 if (key == ' ') {
 
 if (mode == -1) {
 mode = 1;
 }
 }   //mode = mode < 1 ? mode+1 : 0;
 }*/

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
  msql.query( "SELECT COUNT(*) FROM usuarios WHERE CardIDUsuario LIKE '"+id+"%'"); //Se realiza la busqueda del ID dentro de la base de datos
  msql.next();
  if (msql.getInt(1) == 0) {
    /*String Nombre = Dialogo.preguntar("Nombre", "Ingrese su nombre");
     String Correo = Dialogo.preguntar("Correo", "Por favor ingrese aqui su correo");
     elusuario = new Usuario(Nombre, id, Correo, msql);*/
    idreg=id;
    Inicio.setVisible(false);
    sig.setVisible(false);
    email.setVisible(true);
    nombre.setVisible(true);  
    registrar.setVisible(true); 
    nom.setVisible(true); 
    corr.setVisible(true);
  } else { 
    elusuario = new Usuario(id, msql); 
    println("Bienvenido" +" "+elusuario.Nombre);
    elusuario.accion(); //Se llama metodo accion de usuario en el que se comprueba si el usuario tiene o no bici prestada
  }
}

//Primera pantalla, solo se ve una vez
//Configura la estacion en la que se encuentra el computador
void in () {
  msql.query("SELECT NombreEstacion FROM estaciones where EstadoEstacion = false");
  ListaEstacionesO = "Seleccionar Estacion";
  println(ListaEstacionesO);
  while (msql.next()==true) {
    String ListaEstacionestmp = msql.getString(1);
    ListaEstacionesO = ListaEstacionesO+","+ListaEstacionestmp;
  }
  ListaO = split(ListaEstacionesO, ",");
  printArray(ListaO);
  Estaciones1.setItems(ListaO, 0);
  adm.setVisible(true);
  Estaciones1.setVisible(true);
  Inicio.setVisible(false);
  sig.setVisible(false);
  email.setVisible(false);
  nombre.setVisible(false);  
  registrar.setVisible(false); 
  nom.setVisible(false); 
  corr.setVisible(false);
  Pedir.setVisible(false); 
  Devolver.setVisible(false);
  NumBici.setVisible(false);
  ok.setVisible(false);
  preg.setVisible(false);
  Nodis.setVisible(false);
  destino.setVisible(false);
  dest.setVisible(false);
}

//Configuración de la pantalla de inicio
void inicio () {
  /**/
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
  ok.setVisible(false);
  preg.setVisible(false);
  Nodis.setVisible(false);
  adm.setVisible(false);
  Estaciones1.setVisible(false);
  destino.setVisible(false);
  dest.setVisible(false);
}

//Controla el tipo de la letra y el tamaño de la letra, solo se ejecuta una vez
public void customGUI() {
  Inicio.setFont(new Font("Cooper Black", Font.PLAIN, 40));
  email.setFont(new Font("Times New Roman", Font.PLAIN, 20));
  nombre.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  registrar.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  nom.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  corr.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  sig.setFont(new Font("Cooper Black", Font.PLAIN, 30));
  Pedir.setFont(new Font("Cooper Black", Font.PLAIN, 30)); 
  Devolver.setFont(new Font("Cooper Black", Font.PLAIN, 30));  
  NumBici.setFont(new Font("Cooper Black", Font.PLAIN, 30));  
  ok.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  preg.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  Nodis.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  adm.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  Estaciones1.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  dest.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  destino.setFont(new Font("Times New Roman", Font.PLAIN, 22));


  //Cambio del color de las instrucciones
  GCScheme.changePaletteColor(10, 2, color(0, 123, 142));
  GCScheme.changePaletteColor(10, 3, color(0, 123, 142));
  GCScheme.changePaletteColor(10, 4, color(0, 204, 153));
  GCScheme.changePaletteColor(10, 7, color(211, 237, 255));
  GCScheme.changePaletteColor(10, 6, color(211, 237, 255));

  //Control de los colores de los botones
  GCScheme.changePaletteColor(9, 2, color(14, 166, 35));
  GCScheme.changePaletteColor(9, 3, color(0, 204, 153));
  GCScheme.changePaletteColor(9, 4, color(0, 204, 153));
  GCScheme.changePaletteColor(9, 14, color(102, 189, 255));
  GCScheme.changePaletteColor(9, 6, color(102, 241, 175));
  GCScheme.savePalettes(this, "my-palettes.png");
}