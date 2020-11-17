import processing.serial.*;

public class ProtocoloStopAndWait{
  CapaRed capaRed = new CapaRed();
  CapaFisica capaFisica = new CapaFisica();
  
  boolean event;
  public synchronized void wait_for_event (String input) {
    if(input == "frame_arrival"){
      event = true;
    }
    
  }
  
  public void sender(){
    Paquete buffer = new Paquete();
    Frame f = new Frame();
    while(true){
      capaRed.from_network_layer(buffer);
      f.setInfo(buffer);
      capaFisica.to_physical_layer(f);
      wait_for_event("None"); // Esto hay que verlo bien
      while(event == false){
        print("Esperando evento");
      }
    }
  }
  
  public void receiver(){
    Frame r = new Frame();
    Frame s = new Frame();
    while(true){
      wait_for_event("frame_arrival"); // Esto hay que verlo bien
      capaFisica.from_physical_layer(r);
      capaRed.to_network_layer(r.getInfo());
      capaFisica.to_physical_layer(s);
    }
  }
}
