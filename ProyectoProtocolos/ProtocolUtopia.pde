public class ProtocolUtopia extends Protocol implements IUnidireccional{
 
  public ProtocolUtopia(){
    networkLayerA = new NetworkLayer(); //<>// //<>//
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
    Frame r = new Frame(); //<>// //<>//
    r = physicalLayerA.from_physical_layer();
    networkLayerA.to_network_layer(r.getInfo());
    
    dto.setProtocol("Protocolo Utopia");
    dto.setKindError("Sin errores");
    dto.setFrame(r);
    
    sender(false);
  }
}
