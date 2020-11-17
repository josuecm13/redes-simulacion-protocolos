public class CapaFisica{
  Frame frame;
  public Frame from_physical_layer(Frame r){
    return r;
  }
  
  public void to_physical_layer(Frame s){
    frame = s;
  }
  
  public Frame getFrame(){
    return frame;
  }
}
