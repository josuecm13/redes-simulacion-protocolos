public class GuiPath extends Placeable{
  
  ArrayList<PVector> path;
  
  public GuiPath(){
  }
  
  public GuiPath(ArrayList<PVector> path){
    setPath(path);
  }
  
  public void setPath(ArrayList<PVector> path){
    this.path = path;
  }
  
  
  @Override
  public void display(){
    Boolean onProgress = true;
    PVector first, second;
    first = new PVector(0,0);
    for (PVector point: path){
      if(onProgress){
        first = point;
        onProgress = false;
      }else{
        second = point;
        line(first.x, first.y, second.x, second.y);
        first = second;
      }
    }
  }  
}
