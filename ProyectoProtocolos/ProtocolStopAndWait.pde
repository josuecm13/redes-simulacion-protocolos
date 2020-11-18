public class ProtocolStopAndWait extends Protocol implements IUnidireccional{
 
  public ProtocolStopAndWait(){
    networkLayer = new NetworkLayer();
    physicalLayer = new PhysicalLayer();
    sender(false);
  }
  
  public void sender(Boolean error){
    Package buffer = new Package();
    Frame f = new Frame();
    buffer = networkLayer.from_network_layer();
    f.setInfo(buffer);
    physicalLayer.to_physical_layer(f);
  }
  
  public void receiver(){
    int tiempoDelay = (int) random(1000, 3000);
    Frame r = new Frame();
    r = physicalLayer.from_physical_layer();
    print(r.getInfo().getData());
    networkLayer.to_network_layer(r.getInfo());
    delay(tiempoDelay);
    sender(false);
  }
}
