import processing.serial.*;

public class ProtocoloPar{
  CapaRed capaRed = new CapaRed();
  CapaFisica capaFisica = new CapaFisica();
  final StringList event_type = new StringList("frame_arrival", "cksum_err", "timeout");
  
  boolean event;
  
  public synchronized void wait_for_event (boolean input) {
    event = input;
  }
  
  public void sender(){
    Frame f = new Frame();
    Paquete buffer = new Paquete();
    int next_frame_to_send = 0;
    buffer = capaRed.from_network_layer();
    while(true){
      f.setInfo(buffer);
      f.setSeq(next_frame_to_send);
      capaFisica.to_physical_layer(f);
      wait_for_event(false); // Esto hay que verlo bien
      while(event == false){
        print("Esperando evento");
      }
    }
  }
  
  public void receiver(){
    Frame r = new Frame();
    Frame s = new Frame();
    while(true){
      wait_for_event(true); // Esto hay que verlo bien
      capaFisica.from_physical_layer();
      capaRed.to_network_layer(r.getInfo());
      capaFisica.to_physical_layer(s);
    }
  }
}
