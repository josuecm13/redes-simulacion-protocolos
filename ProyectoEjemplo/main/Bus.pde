class Bus{
  int  arms, direction, framecount;
  float xPos, yPos, velocity, initialxPos, initialVel;
  Boolean isMoving; 
  PImage img;
  ArrayList<HittableByCar> victims;
  private int tMessage, offsetX, offsetY;
  
  Bus(float x, float y, float velocity){
    initShape();
    this.offsetX = img.width/2;
    this.xPos = x + offsetX;
    this.initialxPos = xPos;
    this.offsetY = img.height/2;
    this.yPos = y - offsetY;
    this.isMoving = false;
    this.velocity = velocity;
    this.initialVel = velocity;
    this.direction = -1; 
    this.framecount= 0;
    this.tMessage = 1;
    this.victims = new ArrayList();
  }
  
  void initShape(){
    img = loadImage("bus.png");
  }
  
    void move(){
    this.isMoving = true;
  }
  
  void stop(){
    this.isMoving = false;
  }
  
  void triggerMessage(int trigger){
    if(trigger > 0){
      print("current xPos: ",xPos, " yPos: ", yPos);
      tMessage--;
    }
  }
  
  void changeVel(){
    if(xPos < 400 && xPos >= 100  && velocity != 3){
      velocity = 3;
    }else if(xPos < 100 && xPos > 0  && velocity != 2.5){
      velocity = 2.5;
    }else{
      velocity = initialVel;
    }
  }
  
  void subscribeVictim(HittableByCar victim){
    victims.add(victim);
  }
    
  void update(){
    if(isMoving){
      if(xPos < 0){
        for(HittableByCar v: victims){
          v.stop();
        }
        victims.clear();
      }
      if(xPos > - offsetX*2){
        //changeVel();        
        xPos += direction*velocity;
      }else{
        xPos = initialxPos;
        stop();
        triggerMessage(tMessage);
      }
    }
    image(img, xPos, yPos);
    framecount++;
    framecount %= 30;
  }
  
  
}
