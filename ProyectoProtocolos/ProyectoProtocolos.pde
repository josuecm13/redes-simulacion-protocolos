GuiManager gui;

int delay;
int d;


void setup(){
  size(1000,600, P2D);
  
  ArrayList<GuiComponents> comps = new ArrayList();
  comps.add( GuiComponents.MachineA );
  comps.add( GuiComponents.RouterA );
  comps.add( GuiComponents.RouterB );
  comps.add( GuiComponents.MachineB );
  comps.add( GuiComponents.Frame );
  
  delay = 40;
  d = -1;
  gui = new GuiManager(width, height, comps);
  frameRate(gui.refreshRate);
}

void draw(){
  clear();
  background(240);
  gui.display();
  
  if(delay  == 0){
    gui.start();
    d = 40;
  }
  if(d  == 0){
    print("Show Frame");
    gui.showComponent(GuiComponents.Frame,0);
  }
  
  delay--; d --;
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
