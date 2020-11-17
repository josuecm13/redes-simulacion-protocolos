public class CapaRed{
  Paquete paquete;
  
  public Paquete from_network_layer(Paquete p){
    String data = "";
    
    for (int i = 0; i < 1024; i = i+1) {
      int RandomNumber = int(random(2));
      data = data +str (RandomNumber);
    } 
    p.setData(data);
    println(p.data);
    return p;
  }
  
  public void to_network_layer(Paquete p){
    paquete = p;
  }
  
  public Paquete getPaquete(){
    return paquete;
  }
}
