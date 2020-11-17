public class ProtocoloStopAndWait extends Protocolo implements IUnidireccional{
 
  public ProtocoloStopAndWait(){
    capaRed = new CapaRed();
    capaFisica = new CapaFisica();
    receiver();
  }
  
  /*
  public void sender(){
    Paquete buffer = new Paquete();
    Frame f = new Frame();
    while(true){
      capaRed.from_network_layer(buffer);
      f.setInfo(buffer);
      capaFisica.to_physical_layer(f);
    }
  }
  
  public void receiver(){
    Frame r = new Frame();
    while(true){
      capaFisica.from_physical_layer(r);
      capaRed.to_network_layer(r.getInfo());
    }
  }
  */
  
  public void sender(Boolean error){
    Paquete buffer = new Paquete();
    Frame f = new Frame();
    buffer = capaRed.from_network_layer();
    f.setInfo(buffer);
    print(f.getInfo().getData());
    capaFisica.to_physical_layer(f);
  }
  
  public void receiver(){
    Frame r = new Frame();
    delay(4000);
    r = capaFisica.from_physical_layer();
    //print(r.getInfo().getData());
    capaRed.to_network_layer(r.getInfo());
  }
}
