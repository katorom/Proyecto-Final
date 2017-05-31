/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void nombre_change(GTextField source, GEvent event) { //_CODE_:nombre:447644:
  println("nombre - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:nombre:447644:

public void email_change1(GTextField source, GEvent event) { //_CODE_:email:330141:
  println("email - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:email:330141:

public void registrar_click(GButton source, GEvent event) { //_CODE_:registrar:596100:
  println("registrar - GButton >> GEvent." + event + " @ " + millis());
  String Nombre = nombre.getText();
  String Correo = email.getText();
  elusuario = new Usuario(Nombre, idreg, Correo, msql);
  inicio();
} //_CODE_:registrar:596100:

public void Pedir_click1(GButton source, GEvent event) { //_CODE_:Pedir:686565:
  println("Pedir - GButton >> GEvent." + event + " @ " + millis());
  msql.query("SELECT `NombreEstacion` FROM `estaciones` WHERE `NombreEstacion` <> '"+CurrentStation+"'");
  ListaEstacionesD = "Seleccionar Estacion";
  println(ListaEstacionesD);
  while (msql.next()==true) {
    String ListaEstacionestmp = msql.getString(1);
    ListaEstacionesD = ListaEstacionesD+","+ListaEstacionestmp;
    println(ListaEstacionesD);
  }
  ListaD = splitTokens(ListaEstacionesD, ",");
  printArray(ListaD);
  destino.setItems(ListaD, 0);
  Pedir.setVisible(false);
  preg.setVisible(false);
  destino.setVisible(true);
  dest.setVisible(true);
} //_CODE_:Pedir:686565:

public void devolver_click(GButton source, GEvent event) { //_CODE_:Devolver:920879:
  println("Devolver - GButton >> GEvent." + event + " @ " + millis());
  bici.returnBike();
  NumBici.setText(elusuario.Nombre+" has devuelto la bicicleta número: "+ bici.Number);
  Devolver.setVisible(false);
  preg.setVisible(false);
  NumBici.setVisible(true);
  ok.setVisible(true);
} //_CODE_:Devolver:920879:

public void siguiente_click(GButton source, GEvent event) { //_CODE_:sig:625524:
  println("sig - GButton >> GEvent." + event + " @ " + millis());
  Registro();
} //_CODE_:sig:625524:

public void ok_click1(GButton source, GEvent event) { //_CODE_:ok:844847:
  println("ok - GButton >> GEvent." + event + " @ " + millis());
  inicio();
} //_CODE_:ok:844847:

public void Estaciones1_click1(GDropList source, GEvent event) { //_CODE_:Estaciones1:259145:
  println("Estaciones1 - GDropList >> GEvent." + event + " @ " + millis());

  CurrentStation = Estaciones1.getSelectedText ();
  println(CurrentStation);
  station = new Estacion(msql);
  //CurrentStation = station.NameStation;
  IdCurrentStation = station.id_estacion;
  adm.setVisible(false);
  Estaciones1.setVisible(false);
  println("Sali");
  inicio();
} //_CODE_:Estaciones1:259145:

public void destino_click1(GDropList source, GEvent event) { //_CODE_:destino:382050:
  println("destino - GDropList >> GEvent." + event + " @ " + millis());
  String llegada = destino.getSelectedText ();
  bici.assignBike(llegada);
  NumBici.setText(elusuario.Nombre +" toma la bicicleta número: "+ bici.Number);
  destino.setSelected(0);
  destino.setVisible(false);
  dest.setVisible(false);
  NumBici.setVisible(true);
  ok.setVisible(true);
} //_CODE_:destino:382050:

public void setEst_click1(GButton source, GEvent event) { //_CODE_:SetEst:494354:
  //Configura la estacion en la que se encuentra el computador
  println("SetEst - GButton >> GEvent." + event + " @ " + millis());
  SetEst.setVisible(false); 
  modAdm.setVisible(false); 
  modo.setVisible(false);
  msql = new MySQL( this, "192.168.1.67", database, user, pass); // Se crea el objeto tipo SQL para ESTACION
  if (msql.connect()) {
    println("successful connection");
  } else {
    println("failed connection");//Si no, se imprime un mensaje.
    while (true);
  }
  println("Entro modo ESTACION");
  
  println(adminbool);
  adminbool=1;
  //
  msql.query("SELECT NombreEstacion FROM estaciones where EstadoEstacion = false");
  ListaEstacionesO = "Seleccionar Estacion";
  println(ListaEstacionesO);
  while (msql.next()==true) {
    String ListaEstacionestmp = msql.getString(1);
    ListaEstacionesO = ListaEstacionesO+","+ListaEstacionestmp;
  }
  ListaO = splitTokens(ListaEstacionesO, ",");
  printArray(ListaO);
  Estaciones1.setItems(ListaO, 0);
  adm.setVisible(true);
  Estaciones1.setVisible(true);
} //_CODE_:SetEst:494354:

public void modAdm_click1(GButton source, GEvent event) { //_CODE_:modAdm:811607:
  println("modAdm - GButton >> GEvent." + event + " @ " + millis());
  SetEst.setVisible(false); 
  modAdm.setVisible(false); 
  modo.setVisible(false); 
  admUser.setVisible(true); 
  admPass.setVisible(true); 
  admnom.setVisible(true); 
  admcon.setVisible(true); 
  ingresar.setVisible(true);
} //_CODE_:modAdm:811607:

public void modBike_click1(GButton source, GEvent event) { //_CODE_:modBike:638222:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  modBike.setVisible(false); 
  modStat.setVisible(false); 
  quemod.setVisible(false); 
  msjMAdm.setVisible(true);
  anadirb.setVisible(true); 
  borrarb.setVisible(true);
} //_CODE_:modBike:638222:

public void modStat_click1(GButton source, GEvent event) { //_CODE_:modStat:652553:
  println("button2 - GButton >> GEvent." + event + " @ " + millis());
  modBike.setVisible(false); 
  modStat.setVisible(false); 
  quemod.setVisible(false);
  anadirE.setVisible(true); 
  borrarE.setVisible(true);
} //_CODE_:modStat:652553:

public void anadirb_click1(GButton source, GEvent event) { //_CODE_:anadirb:884316:
  println("anadirb - GButton >> GEvent." + event + " @ " + millis());
  msql.query("SELECT NombreEstacion FROM estaciones");
  ListaEstacionesO = "Seleccionar Estacion";
  println(ListaEstacionesO);
  while (msql.next()==true) {
    String ListaEstacionestmp = msql.getString(1);
    ListaEstacionesO = ListaEstacionesO+","+ListaEstacionestmp;
  }
  ListaO = splitTokens(ListaEstacionesO, ",");
  printArray(ListaO);
  addEst.setItems(ListaO, 0);
  anadirb.setVisible(false); 
  borrarb.setVisible(false);
  msjMAdm.setVisible(false);
  CantB.setVisible(true); 
  addEst.setVisible(true); 
  Cbic.setVisible(true);
} //_CODE_:anadirb:884316:

public void borrarb_click1(GButton source, GEvent event) { //_CODE_:borrarb:821566:
  println("borrarb - GButton >> GEvent." + event + " @ " + millis());
  admin.deleteBikes();
  anadirb.setVisible(false); 
  borrarb.setVisible(false);
} //_CODE_:borrarb:821566:

public void anadirE_click1(GButton source, GEvent event) { //_CODE_:anadirE:819507:
  println("anadirE - GButton >> GEvent." + event + " @ " + millis());
  admin.addStation();
  anadirE.setVisible(false); 
  borrarE.setVisible(false);
} //_CODE_:anadirE:819507:

public void borrarE_click1(GButton source, GEvent event) { //_CODE_:borrarE:674434:
  println("borrarE - GButton >> GEvent." + event + " @ " + millis());
  admin.deleteStation();
  anadirE.setVisible(false); 
  borrarE.setVisible(false);
} //_CODE_:borrarE:674434:

public void Salir_click1(GButton source, GEvent event) { //_CODE_:Salir:794701:
  println("Salir - GButton >> GEvent." + event + " @ " + millis());
  if(adminbool==1){
    msql.query("UPDATE estaciones SET EstadoEstacion=false WHERE IdEstacion="+IdCurrentStation+"");
    println(IdCurrentStation);
  }
  println(adminbool);
  exit(); 
} //_CODE_:Salir:794701:

public void admUser_change1(GTextField source, GEvent event) { //_CODE_:admUser:729557:
  println("admUser - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:admUser:729557:

public void admPass_change1(GTextField source, GEvent event) { //_CODE_:admPass:373313:
  println("admPass - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:admPass:373313:

public void ingresar_click1(GButton source, GEvent event) { //_CODE_:ingresar:418275:
  println("ingresar - GButton >> GEvent." + event + " @ " + millis());
  String User = admUser.getText();
  String password = admPass.getText();
  admin = new Administrador(msql, User, password);
  msql = new MySQL( this, "192.168.1.67", database, admin.Nombre, admin.Password); // Se crea el objeto tipo SQL para ADMIN
  if (msql.connect()) {
    println("successful connection");
  } else {
    println("failed connection");//Si no, se imprime un mensaje.
    while (true);
  }
  println("Entro modo ADMIN");
  adminbool=2;
  admUser.setVisible(false); 
  admPass.setVisible(false); 
  admnom.setVisible(false); 
  admcon.setVisible(false); 
  ingresar.setVisible(false);
  modBike.setVisible(true); 
  modStat.setVisible(true); 
  quemod.setVisible(true);
} //_CODE_:ingresar:418275:

public void CantB_change1(GTextField source, GEvent event) { //_CODE_:CantB:853562:
  println("CantB - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:CantB:853562:

public void addEst_click1(GDropList source, GEvent event) { //_CODE_:addEst:555347:
  println("addEst - GDropList >> GEvent." + event + " @ " + millis());
  String cant =  CantB.getText();
  int AT = Integer.parseInt(cant); 
  println(AT);
  String estacion = addEst.getSelectedText ();
  println(AT);
  println(estacion);
  admin.addBikes(AT,estacion);
  Cbic.setVisible(false);
  inadm ();
} //_CODE_:addEst:555347:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  Inicio = new GLabel(this, 69, 228, 700, 160);
  Inicio.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Inicio.setText("Bienvenido, por favor presione siguiente y acerque su carné al lector");
  Inicio.setLocalColorScheme(GCScheme.SCHEME_10);
  Inicio.setOpaque(false);
  nombre = new GTextField(this, 517, 346, 250, 45, G4P.SCROLLBARS_NONE);
  nombre.setPromptText("Nombre");
  nombre.setLocalColorScheme(GCScheme.SCHEME_10);
  nombre.setOpaque(true);
  nombre.addEventHandler(this, "nombre_change");
  email = new GTextField(this, 519, 480, 250, 45, G4P.SCROLLBARS_NONE);
  email.setPromptText("example@unal.edu.co");
  email.setLocalColorScheme(GCScheme.SCHEME_10);
  email.setOpaque(true);
  email.addEventHandler(this, "email_change1");
  registrar = new GButton(this, 350, 618, 140, 70);
  registrar.setText("Registrar");
  registrar.setLocalColorScheme(GCScheme.SCHEME_9);
  registrar.addEventHandler(this, "registrar_click");
  nom = new GLabel(this, 57, 327, 400, 100);
  nom.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  nom.setText("Ingrese su nombre:");
  nom.setLocalColorScheme(GCScheme.SCHEME_10);
  nom.setOpaque(false);
  corr = new GLabel(this, 58, 462, 400, 100);
  corr.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  corr.setText("Ingrse su correo Unal: ");
  corr.setLocalColorScheme(GCScheme.SCHEME_10);
  corr.setOpaque(false);
  Pedir = new GButton(this, 314, 495, 300, 100);
  Pedir.setText("Pedir bicicleta");
  Pedir.setLocalColorScheme(GCScheme.SCHEME_9);
  Pedir.addEventHandler(this, "Pedir_click1");
  Devolver = new GButton(this, 314, 495, 300, 100);
  Devolver.setText("Devolver bicicleta");
  Devolver.setLocalColorScheme(GCScheme.SCHEME_9);
  Devolver.addEventHandler(this, "devolver_click");
  sig = new GButton(this, 272, 516, 350, 120);
  sig.setText("Siguiente");
  sig.setLocalColorScheme(GCScheme.SCHEME_9);
  sig.addEventHandler(this, "siguiente_click");
  NumBici = new GLabel(this, 114, 190, 600, 300);
  NumBici.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  NumBici.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  NumBici.setOpaque(false);
  ok = new GButton(this, 402, 563, 300, 90);
  ok.setText("Ok");
  ok.setLocalColorScheme(GCScheme.SCHEME_9);
  ok.addEventHandler(this, "ok_click1");
  preg = new GLabel(this, 142, 294, 550, 100);
  preg.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  preg.setLocalColorScheme(GCScheme.SCHEME_10);
  preg.setOpaque(false);
  Nodis = new GLabel(this, 134, 289, 550, 120);
  Nodis.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Nodis.setText("Lo sentimos, no hay bicicletas disponibles.");
  Nodis.setLocalColorScheme(GCScheme.SCHEME_10);
  Nodis.setOpaque(false);
  Estaciones1 = new GDropList(this, 278, 429, 250, 200, 4);
  Estaciones1.setItems(loadStrings("list_259145"), 0);
  Estaciones1.setLocalColorScheme(GCScheme.SCHEME_10);
  Estaciones1.addEventHandler(this, "Estaciones1_click1");
  adm = new GLabel(this, 91, 257, 600, 150);
  adm.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  adm.setText("Bienvenido administrador, Seleccione la estación en la que se encuentra:");
  adm.setLocalColorScheme(GCScheme.SCHEME_10);
  adm.setOpaque(false);
  destino = new GDropList(this, 312, 409, 250, 200, 4);
  destino.setItems(loadStrings("list_382050"), 0);
  destino.setLocalColorScheme(GCScheme.SCHEME_10);
  destino.addEventHandler(this, "destino_click1");
  dest = new GLabel(this, 109, 237, 580, 120);
  dest.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  dest.setText("Por favor seleccione su destino: ");
  dest.setLocalColorScheme(GCScheme.SCHEME_10);
  dest.setOpaque(false);
  SetEst = new GButton(this, 310, 516, 260, 100);
  SetEst.setText("Cargar estación ");
  SetEst.setLocalColorScheme(GCScheme.SCHEME_10);
  SetEst.addEventHandler(this, "setEst_click1");
  modAdm = new GButton(this, 310, 352, 260, 100);
  modAdm.setText("Modo Administrador");
  modAdm.setLocalColorScheme(GCScheme.SCHEME_10);
  modAdm.addEventHandler(this, "modAdm_click1");
  modo = new GLabel(this, 150, 232, 550, 100);
  modo.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  modo.setText("Seleccione el modo que desea usar:");
  modo.setLocalColorScheme(GCScheme.SCHEME_10);
  modo.setOpaque(false);
  modBike = new GButton(this, 139, 429, 250, 100);
  modBike.setText("Modificar bicicletas");
  modBike.setLocalColorScheme(GCScheme.SCHEME_9);
  modBike.addEventHandler(this, "modBike_click1");
  modStat = new GButton(this, 507, 428, 250, 100);
  modStat.setText("Modificar Estaciones");
  modStat.setLocalColorScheme(GCScheme.SCHEME_9);
  modStat.addEventHandler(this, "modStat_click1");
  quemod = new GLabel(this, 124, 260, 600, 100);
  quemod.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  quemod.setText("¿Qué desea modificar?");
  quemod.setLocalColorScheme(GCScheme.SCHEME_10);
  quemod.setOpaque(false);
  anadirb = new GButton(this, 147, 431, 250, 100);
  anadirb.setText("Añadir Bicicleta");
  anadirb.setLocalColorScheme(GCScheme.SCHEME_9);
  anadirb.addEventHandler(this, "anadirb_click1");
  borrarb = new GButton(this, 507, 431, 250, 100);
  borrarb.setText("Eliminar Bicicleta");
  borrarb.setLocalColorScheme(GCScheme.SCHEME_9);
  borrarb.addEventHandler(this, "borrarb_click1");
  anadirE = new GButton(this, 144, 433, 250, 100);
  anadirE.setText("Añadir Estación");
  anadirE.setLocalColorScheme(GCScheme.SCHEME_9);
  anadirE.addEventHandler(this, "anadirE_click1");
  borrarE = new GButton(this, 504, 430, 250, 100);
  borrarE.setText("Eliminar Estación");
  borrarE.setLocalColorScheme(GCScheme.SCHEME_9);
  borrarE.addEventHandler(this, "borrarE_click1");
  Salir = new GButton(this, 716, 17, 100, 40);
  Salir.setText("Salir");
  Salir.setLocalColorScheme(GCScheme.RED_SCHEME);
  Salir.addEventHandler(this, "Salir_click1");
  admUser = new GTextField(this, 520, 345, 250, 50, G4P.SCROLLBARS_NONE);
  admUser.setPromptText("Usuario");
  admUser.setLocalColorScheme(GCScheme.SCHEME_10);
  admUser.setOpaque(true);
  admUser.addEventHandler(this, "admUser_change1");
  admPass = new GTextField(this, 520, 479, 250, 50, G4P.SCROLLBARS_NONE);
  admPass.setPromptText("Pasword");
  admPass.setLocalColorScheme(GCScheme.SCHEME_10);
  admPass.setOpaque(true);
  admPass.addEventHandler(this, "admPass_change1");
  admnom = new GLabel(this, 144, 345, 250, 60);
  admnom.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  admnom.setText("Ingrese usuario");
  admnom.setLocalColorScheme(GCScheme.SCHEME_10);
  admnom.setOpaque(false);
  admcon = new GLabel(this, 158, 479, 250, 60);
  admcon.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  admcon.setText("Imgrese la contraseña: ");
  admcon.setLocalColorScheme(GCScheme.SCHEME_10);
  admcon.setOpaque(false);
  ingresar = new GButton(this, 373, 606, 150, 45);
  ingresar.setText("Ingresar");
  ingresar.setLocalColorScheme(GCScheme.SCHEME_9);
  ingresar.addEventHandler(this, "ingresar_click1");
  msjMAdm = new GLabel(this, 125, 264, 600, 70);
  msjMAdm.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  msjMAdm.setText("Seleccione lo que desea hacer:");
  msjMAdm.setLocalColorScheme(GCScheme.SCHEME_10);
  msjMAdm.setOpaque(false);
  CantB = new GTextField(this, 166, 424, 200, 40, G4P.SCROLLBARS_NONE);
  CantB.setPromptText("Cantidad de bicicletas");
  CantB.setLocalColorScheme(GCScheme.SCHEME_9);
  CantB.setOpaque(true);
  CantB.addEventHandler(this, "CantB_change1");
  addEst = new GDropList(this, 504, 428, 220, 160, 3);
  addEst.setItems(loadStrings("list_555347"), 0);
  addEst.setLocalColorScheme(GCScheme.SCHEME_9);
  addEst.addEventHandler(this, "addEst_click1");
  Cbic = new GLabel(this, 117, 196, 600, 200);
  Cbic.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Cbic.setText("Ingrese la cantidad de bicicletas y seleccione la estación a la que quiere añadirlas");
  Cbic.setLocalColorScheme(GCScheme.SCHEME_10);
  Cbic.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GLabel Inicio; 
GTextField nombre; 
GTextField email; 
GButton registrar; 
GLabel nom; 
GLabel corr; 
GButton Pedir; 
GButton Devolver; 
GButton sig; 
GLabel NumBici; 
GButton ok; 
GLabel preg; 
GLabel Nodis; 
GDropList Estaciones1; 
GLabel adm; 
GDropList destino; 
GLabel dest; 
GButton SetEst; 
GButton modAdm; 
GLabel modo; 
GButton modBike; 
GButton modStat; 
GLabel quemod; 
GButton anadirb; 
GButton borrarb; 
GButton anadirE; 
GButton borrarE; 
GButton Salir; 
GTextField admUser; 
GTextField admPass; 
GLabel admnom; 
GLabel admcon; 
GButton ingresar; 
GLabel msjMAdm; 
GTextField CantB; 
GDropList addEst; 
GLabel Cbic; 