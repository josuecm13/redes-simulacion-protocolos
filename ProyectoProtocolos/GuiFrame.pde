/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public class GuiFrame extends Placeable implements Movable{
  
  Updater updater;
  ArrayList<PVector> path;
  Boolean state, displaying;
  double heightProportion = 0.355387523629;
  GuiManager manager;
  
  public GuiFrame(float x, float y, int _width){
    this._width = _width;
    this._height = _width * heightProportion;
    this.pos = new PVector(x,y);
    this.image = loadImage("./img/Frame.png");
    this.updater = new Updater();
    this.state = false;
    this.displaying = true;
    image.resize((int) this._width, (int) this._height);
  }
  
  public void setParent(GuiManager manager){
    this.manager = manager;
    this.updater.manager = this;
  }
  
  public void hide(int index){
    displaying = false;
  }
  
  public GuiFrame(float x, float y){ /*params*/
    this(x, y, 60);
  }
  
  public void setPath(ArrayList<PVector> path){
    this.path = path;
    this.updater.setPath(path);
  }
  
  @Override
  public void display(){ //<>//
    if(displaying){
      super.display();
      if(state)
        update();
    }
  }
  
  public void update(){
    updater.update(this);
  }
  
  public void play(Boolean state){
    this.state = state;
    this.displaying = state;
  }
}
