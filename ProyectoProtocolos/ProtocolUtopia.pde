public class ProtocolUtopia extends Protocol implements IUnidireccional{
 
  public ProtocolUtopia(){
    networkLayer = new NetworkLayer(); //<>// //<>//
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
    Frame r = new Frame(); //<>// //<>//
    r = physicalLayer.from_physical_layer();
    networkLayer.to_network_layer(r.getInfo());
  }
}
