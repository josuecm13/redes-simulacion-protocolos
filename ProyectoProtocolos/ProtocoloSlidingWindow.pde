public class ProtocolSlidingWindow extends Protocol implements IBidireccional{
  
  public ProtocolSlidingWindow(int checksum, int timeout){
    networkLayerA = new NetworkLayer();
    physicalLayerA = new PhysicalLayer();
    this.checksum = checksum;
    this.timeout = timeout;
    next_frame_to_send = 0;
    frame_expected = 0;
    buffer = new Package();
    sender(0, false);
  }
  
  public void sender(int index, Boolean error){
    if(!error){
      if(index == 0){ // A envio B
        Frame f = new Frame();
        buffer = networkLayerA.from_network_layer();
        f.setInfo(buffer);
        f.setSeq(next_frame_to_send);
        f.setAck(1-frame_expected);
        physicalLayerA.to_physical_layer(f);
      }
      else{ // B envio A
        Frame f = new Frame();
        buffer = networkLayerA.from_network_layer();
        f.setInfo(buffer);
        f.setSeq(next_frame_to_send);
        f.setAck(1-frame_expected);
        physicalLayerA.to_physical_layer(f);
      }
    }
  }
  
  public void receiver(int index){ 
    Frame r = new Frame();
    r = physicalLayerA.from_physical_layer();
    
    int tiempoDelay = (int) random(1000, 3000);
    
    float numRanCheck = random(0, 100);
    float numRanTime = random(0, 100);
    boolean checksumOk = (numRanCheck > 50 - checksum/2) && (numRanCheck < 50 + checksum/2);
    boolean timeoutOk = (numRanTime > 50 - timeout/2) && (numRanTime < 50 + timeout/2);
    
    if(!checksumOk){
      if(!timeoutOk){
        if(index == 0){ // B
          if(r.getSeq() == frame_expected){
            networkLayerA.to_network_layer(r.getInfo());
            frame_expected = inc(frame_expected);
          }
          if(r.getAck() == next_frame_to_send){
            buffer = networkLayerA.from_network_layer();
            next_frame_to_send = inc(next_frame_to_send);
          }
          
          dto.setProtocol("Protocolo Sliding Window");
          dto.setKindError("Sin errores");
          dto.setFrame(r);
          
          sender(1, false);
        }
        else{
          if(r.getSeq() == frame_expected){
            networkLayerA.to_network_layer(r.getInfo());
            frame_expected = inc(frame_expected);
          }
          if(r.getAck() == next_frame_to_send){
            buffer = networkLayerA.from_network_layer();
            next_frame_to_send = inc(next_frame_to_send);
          }
          dto.setProtocol("Protocolo Sliding Window");
          dto.setKindError("Sin errores");
          dto.setFrame(r);
          
          sender(0, false);
        }
      }
      else{
        dto.setProtocol("Protocolo Sliding Window");
        dto.setKindError("Error de Timeout");
        dto.setFrame(r);
          
        // print("Delay: " + str(tiempoDelay));
        // delay(tiempoDelay);
        sender(index, true);
      }
    }
    else{
      dto.setProtocol("Protocolo Sliding Window");
      dto.setKindError("Error de Checksum");
      dto.setFrame(r);
      
      // print("Delay: " + str(tiempoDelay));
      // delay(tiempoDelay);
      sender(index, true);
    }
  }
  
  public int inc(int value){
    // MAX_SEQ que entre por parametro desde interfaz
    if(value < 3){
      return value+1;
    }
    else{
      return 0;
    }
  }
}
