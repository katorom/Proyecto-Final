public class Lugar{
  String place;
  
  public Lugar(String Lugar){
    this.place = Lugar;
  }
  
  void asignBici(String Estacion){
    msql.query("SELECT from bicicletas Number,User,Place WHERE Place = '"+Estacion+"' && User = Ninguno"); 
    msql.next();
    int Number = msql.getInt(1);
    String User = msql.getString(2);
    String Place = msql.getString(3);
    
  }
  
}