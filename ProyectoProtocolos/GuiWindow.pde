/*
Author: Josue Canales Mena
Date: 14/11/2020
*/


public class GuiWindow extends Placeable{ 
  
  double heightProportion = 1;
  int capacity, currentFrame;
  
  public GuiWindow(float x, float y, int _width){
    this._width = _width;
    this._height = _width * heightProportion;
    this.pos = new PVector(x,y);
    this.image = loadImage("./img/Router.png");
    image.resize((int) this._width, (int) this._height);
  }
  
  /*Make Rectangle*/
  /* (SET/GET) variables {current, total} */
  
  @Override 
  public void display(){
    /* Something */
  }
  
  private String detail(){
    
    return "";
  }
  
  public GuiWindow(float x, float y){
    this(x,y,60);
  }

}
