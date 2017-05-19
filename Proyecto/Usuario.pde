import de.bezier.data.sql.*;

public class Usuario{
  
    String Nombre;
    String CardID;
    boolean Estado; 
    
    public Usuario(String Nombre, String CardID,MySQL msql){//usuario no registrado
      this.Nombre = Nombre;
      this.CardID = CardID;
      this.Estado = false;
      msql.execute("INSERT INTO usuarios (Nombre,CardID,Estado) values ('"+Nombre+"','"+CardID+"',false)");
    }
    
    public Usuario(String CardID,MySQL msql){//usuario registrado
      msql.query( "SELECT Nombre,Estado FROM usuarios WHERE CardID LIKE '"+CardID+"'");
      msql.next();
      this.Nombre = msql.getString(1);
      this.CardID = CardID;
      this.Estado = msql.getBoolean(2);
    }
}