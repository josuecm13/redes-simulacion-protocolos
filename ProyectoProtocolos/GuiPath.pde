/*
Author: Josue Canales Mena
Date: 08/11/2020
*/


public class GuiPath extends Placeable{
  
  ArrayList<PVector> path;
  
  public GuiPath(){
    this.pos = new PVector(0,0);
  }
  
  public GuiPath(ArrayList<PVector> path){
    this();
    setPath(path);
  }
  
  public void setPath(ArrayList<PVector> path){
    this.pos.x = path.get(0).x;
    this.pos.y = path.get(0).y;
    this.path = path;
  }
  
  
  @Override
  public void display(){
    Boolean onProgress = true;
    PVector first, second;
    first = new PVector(0,0);
    for (PVector point: this.path){
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
