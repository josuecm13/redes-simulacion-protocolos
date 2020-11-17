/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public class Updater{
  Boolean xAxis;
  ArrayList<PVector> fullPath;
  float stepRate;
  int direction;
  PVector currentGoal;
  GuiFrame manager;
  
  private int moment;
  private Boolean isUpward;
  private Boolean isLeftToRight;
  
  public Updater(){
    this.xAxis = false;
    moment = 1;
    direction = 1;
    setStepRate(5);
  }
  
  public Updater(ArrayList<PVector> fullpath){
    setStepRate(5);
    setPath(fullpath);
  }
  
  public void setPath(ArrayList<PVector> fullpath){
    this.fullPath = fullpath;
    this.xAxis = false;
    moment = 1;
    direction = 1;
    checkDirection();
    checkOrientation();
    rollFirstItem();
  }
  
  public void update(Placeable item){
    if (xAxis){
      item.pos.x += stepRate * direction;
      if(item.pos.x >= fullPath.get(0).x && isLeftToRight){
        item.pos.x = fullPath.get(0).x;
        moment++;
        rollFirstItem();
        direction = isUpward ? 1: -1;
        xAxis = false;
      }
      else if (item.pos.x <= fullPath.get(0).x && !isLeftToRight){
        item.pos.x = fullPath.get(0).x;
        moment++;
        rollFirstItem();
        direction = isUpward ? 1: -1;
        xAxis = false;
      }
    }else{
      item.pos.y += stepRate * direction;
      if(item.pos.y <= fullPath.get(0).y && ((moment == 1 && isUpward) || (moment == 3 && !isUpward)) ){
        item.pos.y = fullPath.get(0).y;
        moment++;
        rollFirstItem();
        direction = isLeftToRight ? 1: -1;
        xAxis = true;
      }
      if(item.pos.y >= fullPath.get(0).y && ((moment == 1 && !isUpward) || (moment == 3 && isUpward)) ){
        item.pos.y = fullPath.get(0).y;
        moment++;
        rollFirstItem();
        direction = isLeftToRight ? 1: -1;
        xAxis = true;
      }
      if (moment == 4){ /* IMPORTANTE: AQUI EL PAQUETE LLEGÓ AL OTRO ROUTER*/
        item.pos.x = fullPath.get(0).x;
        item.pos.y = fullPath.get(0).y;
        rollFirstItem();
        moment = 1;
        direction = isUpward ? -1: 1;
        xAxis = false;
        
        if(isLeftToRight)
          this.manager.hide(0); //<>//
        else
          this.manager.hide(1);
        frameSent();
      }
    }
  }
  
  public void frameSent(){
    this.manager.arrived = true;
    print("Entregó Frame\n");
  }
  
  public void setStepRate(float stepRate){
    this.stepRate = stepRate;
  }
  
  private void rollFirstItem(){
    currentGoal = fullPath.remove(0);
    fullPath.add(currentGoal);
  }
  
  /* Checks if goes Up or Down */
  private void checkDirection(){
    if (this.fullPath.size() != 4)
      return;
    if( this.fullPath.get(0).y < this.fullPath.get(1).y )
      isUpward = false;
    else{
      isUpward = true;
      direction = -1;
    }
  }
  
  /* Checks if goes From Left to Right or Viceversa */
  private void checkOrientation(){
    if (this.fullPath.size() != 4)
      return;
    if( this.fullPath.get(1).x < this.fullPath.get(2).x ){
      isLeftToRight = true;
    }else{
      isLeftToRight = false;
    }
  }
}
