/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public class GuiFrame extends Placeable implements Movable{
  
  Updater updater;
  ArrayList<PVector> path;
  double heightProportion = 0.355387523629;
  
  public GuiFrame(float x, float y, int _width){
    this._width = _width;
    this._height = _width * heightProportion;
    this.pos = new PVector(x,y);
    this.image = loadImage("./img/Frame.png");
    this.updater = new Updater();
    image.resize((int) this._width, (int) this._height);
  }
  
  public GuiFrame(float x, float y){ /*params*/
    this(x, y, 60);
  }
  
  public void setPath(ArrayList<PVector> path){
    this.path = path;
    this.updater.setPath(path);
  }
  
  public void update(){
    updater.update(this);
    display();
  }
}
