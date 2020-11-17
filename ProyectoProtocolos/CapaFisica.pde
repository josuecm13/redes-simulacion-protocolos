public class CapaFisica{
  Frame frame;
  
  public CapaFisica(){
    frame = new Frame();
  }
   
  public Frame from_physical_layer(){
    return frame;
  }
  
  public void to_physical_layer(Frame s){
    frame = s;
  }
}
