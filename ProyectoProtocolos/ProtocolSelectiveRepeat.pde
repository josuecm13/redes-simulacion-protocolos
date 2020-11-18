public class ProtocolSelectiveRepeat extends Protocol implements IBidireccional{
 
  DtoManager registroError = new DtoManager();
  public ProtocolSelectiveRepeat(int checksum, int timeout){
    networkLayer = new NetworkLayer();
    physicalLayer = new PhysicalLayer();
    this.checksum = checksum;
    this.timeout = timeout;
    sender(0, false);
  }
  
  public void sender(int index, Boolean error){
    Package buffer = new Package();
    Frame f = new Frame();
    buffer = networkLayer.from_network_layer();
    f.setInfo(buffer);
    physicalLayer.to_physical_layer(f);
  }
  
  public void receiver(int index){
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
        sender(1, false);
      }
      else{
        registroError.setProtocol("Protocolo Selective Repeat");
        registroError.setKindError("Error de Timeout");
        registroError.setFrame(r);
        
        print(registroError.getProtocol());
        print(registroError.getKindError());
        
        delay(tiempoDelay);
        sender(1, true);
      }
    }
    else{
      registroError.setProtocol("Protocolo Selective Repeat");
      registroError.setKindError("Error de Checksum");
      registroError.setFrame(r);
      
      print(registroError.getProtocol());
      print(registroError.getKindError());
      
      delay(tiempoDelay);
      sender(1, true);
    }
  }
}
