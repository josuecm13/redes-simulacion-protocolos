public class CapaRed{
  Paquete paquete;
  
  public CapaRed(){
    paquete = new Paquete();
  }
  
  public Paquete from_network_layer(){
    String data = "";
    
    for (int i = 0; i < 1024; i = i+1) {
      int RandomNumber = int(random(2));
      data = data +str (RandomNumber);
    } 
    paquete.setData(data);
    println(paquete.data);
    return paquete;
  }
  
  public void to_network_layer(Paquete p){
    paquete = p;
  }
  
  public Paquete getPaquete(){
    return paquete;
  }
}
