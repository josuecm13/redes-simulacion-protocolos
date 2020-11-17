public class Timer{
  long tiempo = 0;
  boolean event;
  
  public synchronized void expiracionTemporizador (boolean input) {
    event = input;
  }
  
  public void start_timer(){
    long tiempoInicio = millis();
  }
  
  public void stop_timer(){
   
  }
  
  public void start_ack_timer(){
    
  }
  
  public void stop_ack_timer(){
    
  }
}
