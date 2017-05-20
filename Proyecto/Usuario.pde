import de.bezier.data.sql.*;
//clase usuario
public class Usuario {
  //Todos los usuarios del sistema tendrán estos atributos.
  String Nombre; //Es el nombre de la persona, se usa para terminos de claridad y de entendimiento de los usuarios.
  String CardID;  //Es el ID del carnet, nos permite la autenticación del usuario.
  boolean Estado; //Es un booleano que nos permite saber si el usuario esta activo: true (usandouna bici) o inactivo: false (ya ha devuelto la bici)

  //Se crea un primer constructor del objeto, este constructor se usa para cuando el usuario no se ha registrado

  public Usuario(String Nombre, String CardID, MySQL msql) {//usuario no registrado                         
    this.Nombre = Nombre;                                                                                 
    this.CardID = CardID;                                                                                 
    this.Estado = false;                                                                                  
    msql.execute("INSERT INTO usuarios (Nombre,CardID,Estado) values ('"+Nombre+"','"+CardID+"',false)");
  }                                                                                                       

  //Se crea un segundo constructor, el cual se usa para un usuario registrado, este constructor solo recibe dos parametros
  public Usuario(String CardID, MySQL msql) {//usuario registrado                                           
    msql.query( "SELECT Nombre,Estado FROM usuarios WHERE CardID LIKE '"+CardID+"'");                     
    msql.next();                                                                                          
    this.Nombre = msql.getString(1);                                                                      
    this.CardID = CardID;                                                                                 
    this.Estado = msql.getBoolean(2);
  }  
  void askfBike() {
    myPort.clear();
    myPort.write(1); 
    println("has pedido una bici" + "" + Nombre);
    delay(3000);
  }
}