public class ProtocolStopAndWait extends Protocol implements IUnidireccional{
 
  public ProtocolStopAndWait(){
    networkLayerA = new NetworkLayer();
    physicalLayerA = new PhysicalLayer();
    sender(false);
  }
  
  public void sender(Boolean error){
    Package buffer = new Package();
    Frame f = new Frame();
    buffer = networkLayerA.from_network_layer();
    f.setInfo(buffer);
    physicalLayerA.to_physical_layer(f);
  }
  
  public void receiver(){
    int tiempoDelay = (int) random(1000, 3000);
    Frame r = new Frame();
    r = physicalLayerA.from_physical_layer();
    print(r.getInfo().getData());
    networkLayerA.to_network_layer(r.getInfo());
    delay(tiempoDelay);
    sender(false);
  }
}
