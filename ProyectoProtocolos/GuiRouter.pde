/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public class GuiRouter extends Placeable{ 
  
  double heightProportion = 1;
  
  public GuiRouter(float x, float y, int _width){
    this._width = _width;
    this._height = _width * heightProportion;
    this.pos = new PVector(x,y);
    this.image = loadImage("./img/Router.png");
    image.resize((int) this._width, (int) this._height);
  }
  
  
  public GuiRouter(float x, float y){
    this(x,y,60);
  }

}
