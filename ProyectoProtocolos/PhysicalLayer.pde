public class PhysicalLayer{
  Frame frame;
  
  public PhysicalLayer(){
    frame = new Frame();
  }
   
  public Frame from_physical_layer(){
    return frame;
  }
  
  public void to_physical_layer(Frame f){
    frame = f;
  }
}
