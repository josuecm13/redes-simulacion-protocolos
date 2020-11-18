public class NetworkLayer{
  Package pack;
  
  public NetworkLayer(){
    pack = new Package();
  }
  
  public Package from_network_layer(){
    String data = "";
    
    for (int i = 0; i < 1024; i = i+1) {
      int RandomNumber = int(random(2));
      data = data +str (RandomNumber);
    } 
    pack.setData(data);
    return pack;
  }
  
  public void to_network_layer(Package p){
    pack = p;
  }
  
  public Package getPack(){
    return pack;
  }
}
