public class ProtocolPar extends Protocol implements IUnidireccional{
  
  public ProtocolPar(int checksum, int timeout){
    networkLayer = new NetworkLayer();
    physicalLayer = new PhysicalLayer();
    this.checksum = checksum;
    this.timeout = timeout;
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
    Frame r = new Frame();
    r = physicalLayer.from_physical_layer();
    
    int tiempoDelay = (int) random(1000, 3000);
    
    float numRanCheck = random(0, 100);
    float numRanTime = random(0, 100);
    boolean checksumOk = (numRanCheck > 50 - checksum/2) && (numRanCheck < 50 + checksum/2);
    boolean timeoutOk = (numRanTime > 50 - timeout/2) && (numRanTime < 50 + timeout/2);
    
    if(!checksumOk){
      if(!timeoutOk){
        networkLayer.to_network_layer(r.getInfo());
        delay(tiempoDelay);
        sender(false);
      }
      else{
        dto.setProtocol("Protocolo PAR");
        dto.setKindError("Error de Timeout");
        dto.setFrame(r);
        
        print(dto.getProtocol());
        print(dto.getKindError());
        
        delay(tiempoDelay);
        sender(true);
      }
    }
    else{
      dto.setProtocol("Protocolo PAR");
      dto.setKindError("Error de Checksum");
      dto.setFrame(r);
      
      print(dto.getProtocol());
      print(dto.getKindError());
      
      delay(tiempoDelay);
      sender(true);
    }
  }
}
