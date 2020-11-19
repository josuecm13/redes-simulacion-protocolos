public class ProtocolPar extends Protocol implements IUnidireccional{
  
  public ProtocolPar(int checksum, int timeout){
    networkLayerA = new NetworkLayer();
    physicalLayerA = new PhysicalLayer();
    this.checksum = checksum;
    this.timeout = timeout;
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
    Frame r = new Frame();
    r = physicalLayerA.from_physical_layer();
    
    int tiempoDelay = (int) random(1000, 3000);
    
    float numRanCheck = random(0, 100);
    float numRanTime = random(0, 100);
    boolean checksumOk = (numRanCheck > 50 - checksum/2) && (numRanCheck < 50 + checksum/2);
    boolean timeoutOk = (numRanTime > 50 - timeout/2) && (numRanTime < 50 + timeout/2);
    
    if(!checksumOk){
      if(!timeoutOk){
        networkLayerA.to_network_layer(r.getInfo());
        
        dto.setProtocol("Protocolo PAR");
        dto.setKindError("Sin errores");
        dto.setFrame(r);
        
        println("Delay: " + str(tiempoDelay));
        delay(tiempoDelay);
        
        sender(false);
      }
      else{
        dto.setProtocol("Protocolo PAR");
        dto.setKindError("Error de Timeout");
        dto.setFrame(r);
       
        println("Delay: " + str(tiempoDelay)); 
        delay(tiempoDelay);
        sender(true);
      }
    }
    else{
      dto.setProtocol("Protocolo PAR");
      dto.setKindError("Error de Checksum");
      dto.setFrame(r);
      
      println("Delay: " + str(tiempoDelay));
      delay(tiempoDelay);
      sender(true);
    }
  }
}
