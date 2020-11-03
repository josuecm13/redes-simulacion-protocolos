class Bob implements HittableByCar{
  int  arms, direction, framecount;
  float xPos, yPos, angle, velocity, xLimit;
  Boolean isMoving; 
  PShape shape;
  private int tMessage;
  
  Bob(float x, float y){
    this.xPos = x;
    this.yPos = y;
    this.isMoving = false;
    this.velocity = 4;
    this.direction = 1; 
    this.framecount= 0;
    this.tMessage = 1;
    this.angle = 0.17;
    square();
  }
  
  void square(){
    shape = createShape();
    shape.beginShape();
    shape.vertex(-50, 50);
    shape.vertex(50, 50);
    shape.vertex(50, -50);
    shape.vertex(-50, -50);
    shape.endShape();
    shape.setStroke(color(255-50, 246-50, 119-50));
    shape.setFill(color(255, 246, 119));
  }

  void move(){
    this.velocity = 4;
    this.isMoving = true;
  }
  
  void setLimit(float limit){
    this.xLimit = limit;
  }
  
  void stop(){
    xPos = - 60;
    this.isMoving = false;
  }
  
  void triggerMessage(int trigger){
    if(trigger > 0){
      print("current xPos: ",xPos, " yPos: ", yPos);
      tMessage--;
    }
  }
    
  void update(){
    if(isMoving){
      if(xPos < xLimit){
        xPos += direction*velocity;
      }else if(xPos >= xLimit && xPos < height){
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
