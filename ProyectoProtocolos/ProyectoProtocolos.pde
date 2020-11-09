PImage a, b, router;

void setup(){
  size(1000,600, P2D);
  background(240);
  
  /*Loading Images*/
  a = loadImage("./img/MachineA.png");
  b = loadImage("./img/MachineB.png");
  router = loadImage("./img/Router.png");
  
  /*Resizing images*/
  a.resize(60,60);
  b.resize(60,60);
  router.resize(60, 35);
}


void draw(){
  image(a, (width/2 -30) - 350, (height/2 - 30) - 100 );
  image(b, (width/2 -30) + 350, (height/2 - 30) - 100 );
  image(router, (width/2 - 30) - 200, (height/2 -17) - 100 );
  image(router, (width/2 - 30) + 200, (height/2 -17) - 100 );
}
 /*
PFont myFont;
void setup(){
  myFont = createFont("Arial",12);
  size(220,220);
  textFont(myFont);
}
void draw(){
  background(0);
  noStroke();
  fill(0,128,0);
  ellipse(110,110,120,120);
  if(dist(mouseX,mouseY,110,110)<60){
    fill(255);
    text("Boop!",mouseX-20,mouseY-10);
  }
}

*/
