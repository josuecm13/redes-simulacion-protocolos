public class ProtocolSelectiveRepeat extends Protocol implements IBidireccional{
 
  int next_frame_to_send2 = 0;
  ArrayList<ArrayList> framesPacks = new ArrayList();
  public ProtocolSelectiveRepeat(int checksum, int timeout, int windowSizeA, int windowSizeB){
    networkLayerA = new NetworkLayer();
    physicalLayerB = new PhysicalLayerB();
    this.checksum = checksum;
    this.timeout = timeout;
    next_frame_to_send = 0;
    frame_expected = 0;
    buffer = new Package();
    this.windowSize = windowSizeA;
    this.windowSizeB = windowSizeB;
    ack_expected = 0;
    framePacks = new ArrayList<Frame>();
    framesPacks.add(new ArrayList<Frame>());
    framesPacks.add(new ArrayList<Frame>());
    sender(0, false);
  }
  
  public void sender(int index, Boolean error){
    if(!error){
      if(index == 0){ // A envio B
        for(int i = 0; i < (windowSize - framesPacks.get(0).size()); i++){
          Frame f = new Frame();
          buffer = networkLayerA.from_network_layer();
          f.setInfo(buffer);
          f.setSeq(next_frame_to_send);
          framesPacks.get(0).add(f);
          next_frame_to_send = inc(next_frame_to_send);
        }
        physicalLayerB.to_physical_layer(framesPacks.get(0));
      }
      else{ // B envio A
        for(int i = 0; i < (windowSizeB - framesPacks.get(1).size()); i++){
          Frame f = new Frame();
          buffer = networkLayerA.from_network_layer();
          f.setInfo(buffer);
          f.setSeq(next_frame_to_send2);
          framesPacks.get(1).add(f);
          next_frame_to_send2 = inc(next_frame_to_send2);
        }
        physicalLayerB.to_physical_layer(framesPacks.get(1));
      }
    }
  }
  
  public void receiver(int index){ 
    ArrayList<Frame> r = new ArrayList<Frame>();
    r = physicalLayerB.from_physical_layer();
    ArrayList<String> windowAString = new ArrayList();
    
    ArrayList<Frame> framesWindow = new ArrayList<Frame>();
    Frame frame = new Frame();
    
    int tiempoDelay = (int) random(1000, 3000);
    
    float numRanCheck = random(0, 100);
    float numRanTime = random(0, 100);
    boolean checksumOk = (numRanCheck > 50 - checksum/2) && (numRanCheck < 50 + checksum/2);
    boolean timeoutOk = (numRanTime > 50 - timeout/2) && (numRanTime < 50 + timeout/2);
    
    if(!checksumOk){
      if(!timeoutOk){
        if(index == 0){ // B
          for(int i = 0; r.size() > 0 && framesWindow.size() < windowSizeB; i++){
            if(i < windowSize && i < windowSizeB){
              framesWindow.add(r.remove(0));
            }
          }
          int i;
          String winA = "Ventana B: [";
          for(i = 0; i < framesWindow.size(); i++){
            frame = framesWindow.get(i);
            frame.setAck((frame.getSeq() + 7) % (7+1));
            winA += ("(" + frame.getSeq() + "," + frame.getAck() + ")," );
            networkLayerA.to_network_layer(frame.getInfo());  
          }
            
          winA = winA.substring(0, winA.length()-1);
          winA += "] " + i + "/" + windowSizeB;
          windowAString.add(winA);
          
          dto.setProtocol("Protocolo Selective Repeat");
          dto.setKindError("Sin errores");
          dto.setFrame(frame);
          dto.setWindowInfo(windowAString);
          
          sender(1, false);
        }
        else{ // A
          for(int i = 0; r.size() > 0 && framesWindow.size() < windowSize; i++){
            if(i < windowSizeB && i < windowSize){
              framesWindow.add(r.remove(0));
            }
          }
          int i;
          String winB = "Ventana A: [";
          for(i = 0; i < framesWindow.size(); i++){
            frame = framesWindow.get(i);
            frame.setAck((frame.getSeq() + 7) % (7+1));
            winB += ("(" + frame.getSeq() + "," + frame.getAck() + ")," );
            networkLayerA.to_network_layer(frame.getInfo());  
          }
            
          winB = winB.substring(0, winB.length()-1);
          winB += "] " + i + "/" + windowSize;
          windowAString.add(winB);
          
          dto.setProtocol("Protocolo Selective Repeat");
          dto.setKindError("Sin errores");
          dto.setFrame(frame);
          dto.setWindowInfo(windowAString);
          
          sender(0, false);
        }
      }
      else{
        frame = r.get(0);
        
        dto.setProtocol("Protocolo Selective Repeat");
        dto.setKindError("Error de Timeout");
        dto.setFrame(frame);
          
        // print("Delay: " + str(tiempoDelay));
        // delay(tiempoDelay);
        sender(index, true);
      }
    }
    else{
      frame = r.get(0);
      
      dto.setProtocol("Protocolo Selective Repeat");
      dto.setKindError("Error de Checksum");
      dto.setFrame(frame);
      
      print(dto.getProtocol());
      print(dto.getKindError());
      
      // print("Delay: " + str(tiempoDelay));
      // delay(tiempoDelay);
      sender(index, true);
    }
  }
  
  public int inc(int value){
    // MAX_SEQ que entre por parametro desde interfaz
    if(value < 7){
      return value+1;
    }
    else{
      return 0;
    }
  }
}
