/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public class GuiMachine extends Placeable{
  
  double heightProportion = 1;
  MachineType type;
  
  public GuiMachine(float x, float y, int _width, MachineType type){
    this._width = _width;
    this._height = _width * heightProportion;
    this.pos = new PVector(x,y);
    if (MachineType.A == type)
      this.image = loadImage("./img/MachineA.png");
    else if (MachineType.B == type)
      this.image = loadImage("./img/MachineB.png");
    this.type = type;
    image.resize((int) this._width, (int) this._height);
  }
  
  public GuiMachine(float x, float y, MachineType type){ /*params*/
     this(x, y,60,type);
  }
}


public enum MachineType{
  A, B
}
