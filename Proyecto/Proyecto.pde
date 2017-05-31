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
Administrador admin;

//Varialbles necesarias para el constructor del objeto SQL
String user     = "root4";
String pass     = "nolecreo";
String database = "proyectopoo";
String ListaEstacionesO;
String ListaEstacionesD;
String CurrentStation;
int IdCurrentStation;
String idreg;
PImage bg; //Variable de imagen para fondo
String ListaO [];
String ListaD [];
int adminbool = 0;

void setup() {
  size(845, 800);
  bg = loadImage("bicirrun2.jpg"); //Se carga imagen para el fondo 
  createGUI(); //Funcion de la interfaz gráfica, autogenerada
  customGUI();
  String portName = Serial.list()[0]; //Se selecciona el puerto serie de ARDUINO
  myPort = new Serial(this, portName, 9600); //Se crea el objeto tipo Serie
  prim();
}

void draw() {
  background(bg);
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
void prim () {
  Inicio.setVisible(false); 
  nombre.setVisible(false); 
  email.setVisible(false); 
  registrar.setVisible(false); 
  nom.setVisible(false); 
  corr.setVisible(false); 
  Pedir.setVisible(false); 
  Devolver.setVisible(false); 
  sig.setVisible(false); 
  NumBici.setVisible(false); 
  ok.setVisible(false); 
  preg.setVisible(false); 
  Nodis.setVisible(false); 
  Estaciones1.setVisible(false); 
  adm.setVisible(false); 
  destino.setVisible(false); 
  dest.setVisible(false); 
  SetEst.setVisible(true); 
  modAdm.setVisible(true); 
  modo.setVisible(true); 
  modBike.setVisible(false); 
  modStat.setVisible(false); 
  quemod.setVisible(false); 
  anadirb.setVisible(false); 
  borrarb.setVisible(false); 
  anadirE.setVisible(false); 
  borrarE.setVisible(false); 
  admUser.setVisible(false); 
  admPass.setVisible(false); 
  admnom.setVisible(false); 
  admcon.setVisible(false); 
  ingresar.setVisible(false);
  CantB.setVisible(false); 
  addEst.setVisible(false);
  msjMAdm.setVisible(false);
  Cbic.setVisible(false);
  listEliminar.setVisible(false); 
  tborrab.setVisible(false); 
  nuevaEst.setVisible(false); 
  tnEst.setVisible(false); 
  crearE.setVisible(false);
  modMulta.setVisible(false); 
  lMulta.setVisible(false); 
  borrarMulta.setVisible(false); 

}

void inadm () {
  modBike.setVisible(true); 
  modStat.setVisible(true);
  modMulta.setVisible(true); 
  quemod.setVisible(true); 
  anadirb.setVisible(false); 
  borrarb.setVisible(false); 
  anadirE.setVisible(false); 
  borrarE.setVisible(false); 
  admUser.setVisible(false); 
  admPass.setVisible(false); 
  admnom.setVisible(false); 
  admcon.setVisible(false); 
  ingresar.setVisible(false);
  CantB.setVisible(false); 
  addEst.setVisible(false); 
  Cbic.setVisible(false);
  listEliminar.setVisible(false);
  tborrab.setVisible(false); 
  listEliminarE.setVisible(false); 
  tborrarE.setVisible(false);
  nuevaEst.setVisible(false); 
  tnEst.setVisible(false); 
  crearE.setVisible(false);
  lMulta.setVisible(false); 
  borrarMulta.setVisible(false); 
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
  SetEst.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  modAdm.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  modo.setFont(new Font("Cooper Black", Font.PLAIN, 35)); 
  modBike.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  modStat.setFont(new Font("Cooper Black", Font.PLAIN, 25)); 
  quemod.setFont(new Font("Cooper Black", Font.PLAIN, 35)); 
  anadirb.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  borrarb.setFont(new Font("Cooper Black", Font.PLAIN, 25)); 
  anadirE.setFont(new Font("Cooper Black", Font.PLAIN, 25)); 
  borrarE.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  admUser.setFont(new Font("Times New Roman", Font.PLAIN, 22)); 
  admPass.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  admnom.setFont(new Font("Cooper Black", Font.PLAIN, 25)); 
  admcon.setFont(new Font("Cooper Black", Font.PLAIN, 25)); 
  ingresar.setFont(new Font("Cooper Black", Font.PLAIN, 25));
  msjMAdm.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  Cbic.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  CantB.setFont(new Font("Times New Roman", Font.PLAIN, 22)); 
  addEst.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  listEliminar.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  tborrab.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  listEliminarE.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  tborrarE.setFont(new Font("Cooper Black", Font.PLAIN, 35));
  nuevaEst.setFont(new Font("Times New Roman", Font.PLAIN, 22));
  tnEst.setFont(new Font("Cooper Black", Font.PLAIN, 35)); 
  crearE.setFont(new Font("Cooper Black", Font.PLAIN, 25));


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