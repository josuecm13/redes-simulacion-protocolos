class Patricio implements HittableByCar{
  int  arms, direction, framecount;
  float xPos, yPos, angle, velocity, xLimit;
  Boolean isMoving; 
  PShape shape;
  private int tMessage;
  
  Patricio(float x, float y, int arms){
    this.xPos = x;
    this.yPos = y;
    this.arms = arms;
    this.isMoving = false;
    this.velocity = 5;
    this.direction = -1; 
    this.framecount= 0;
    this.tMessage = 1;
    this.angle = 0.17;
    starv2();
  }
  
  void starv2(){
    shape = createShape();
    shape.beginShape();
    shape.vertex(0, -50);
    shape.vertex(14, -20);
    shape.vertex(47, -15);
    shape.vertex(23, 7);
    shape.vertex(29, 40);
    shape.vertex(0, 25);
    shape.vertex(-29, 40);
    shape.vertex(-23, 7);
    shape.vertex(-47, -15);
    shape.vertex(-14, -20);
    shape.endShape();
    shape.setStroke(color(252-50, 136-50, 112-50));
    shape.setFill(color(252, 136, 112));
  }
  
  void move(){
    this.velocity = 4;
    this.isMoving = true;
  }
  
  void stop(){
    this.xPos = width + 50;
    this.isMoving = false;
  }
  
  void triggerMessage(int trigger){
    if(trigger > 0){
      print("current xPos: ",xPos, " yPos: ", yPos);
      tMessage--;
    }
  }
  
  void setLimit(float limit){
    this.xLimit = limit;
  }
    
  void update(){
    if(isMoving){
      if(xPos > xLimit){
        xPos += direction*velocity;
      }else if(xPos <= xLimit && xPos > 0){
        velocity = 0;
      }else{
        stop();
        triggerMessage(tMessage);
      }
      if(framecount%5 == 0){
        angle *= -1;
        shape.rotate(angle);
      }
    }
    shape(shape,xPos,yPos);
    framecount++;
    framecount %= 30;
  }
  
  
  
  
}
