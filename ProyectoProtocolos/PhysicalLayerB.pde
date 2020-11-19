public class PhysicalLayerB{
  ArrayList<Frame> framePacks;
  int windowSize;
  
  public PhysicalLayerB(int windowSize){
    framePacks = new ArrayList<Frame>();
    this.windowSize = windowSize;
  }
   
  public ArrayList<Frame> from_physical_layer(){
    return framePacks;
  }
  
  public void to_physical_layer(ArrayList<Frame> f){
    framePacks = f;
  }
}
