public class ProtocolSlidingWindow extends Protocol implements IBidireccional{
 
  //ArrayList<Package> packs = new ArrayList<Package>();
  
  public ProtocolSlidingWindow(int checksum, int timeout){
    networkLayer = new NetworkLayer();
    physicalLayer = new PhysicalLayer();
    this.checksum = checksum;
    this.timeout = timeout;
    next_frame_to_send = 0;
    frame_expected = 0;
    buffer = new Package();
    sender(1, false);
  }
  
  public void sender(int index, Boolean error){
    if(index == 1){
      Frame f = new Frame();
      buffer = networkLayer.from_network_layer();
      f.setInfo(buffer);
      f.setSeq(next_frame_to_send);
      f.setAck(1-frame_expected);
      physicalLayer.to_physical_layer(f);
    }
    else{
      
    }
    
  }
  
  public void receiver(int index){
    if(index == 0){
      Frame r = new Frame();
      r = physicalLayer.from_physical_layer();
      if(r.getSeq() == frame_expected){
        networkLayer.to_network_layer(r.getInfo());
        frame_expected = inc(frame_expected);
      }
      if(r.getAck() == next_frame_to_send){
        buffer = networkLayer.from_network_layer();
        next_frame_to_send = inc(next_frame_to_send);
      }
    }
    else{
      
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
