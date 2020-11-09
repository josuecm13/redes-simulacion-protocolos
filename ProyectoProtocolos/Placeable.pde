/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public abstract class Placeable{
  PImage image;
  PVector pos;
  double _width;
  double _height;
  
  public void display(){
    image(image,  (float) (pos.x - (_width/2)), (float) (pos.y - (_height/2)));
  }
  
  
}
