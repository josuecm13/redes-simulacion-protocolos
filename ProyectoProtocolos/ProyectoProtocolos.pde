Placeable machineA, machineB, routerA, routerB;
GuiPath lineAtoB, lineBtoA, lineAtoRouter, lineBtoRouter;
Movable frame, f2; 
int delay;

ArrayList<Placeable> components;
ArrayList<PVector> path, path2, conn1, conn2;

void setup(){
  size(1000,600, P2D);
  frameRate(600);
  lineAtoB = new GuiPath();
  lineBtoA = new GuiPath();
  lineAtoRouter = new GuiPath();
  lineBtoRouter = new GuiPath();
  
  delay = 150;
  
  machineA = new GuiMachine((width/2 - 300),( height/2 - 150), MachineType.A);
  machineB = new GuiMachine((width/2 + 300),( height/2 - 50), MachineType.B);
  routerA = new GuiRouter((width/2 - 150),( height/2 - 150));
  routerB = new GuiRouter((width/2 + 150),( height/2 - 50));
  frame = new GuiFrame(routerA.pos.x, routerA.pos.y);
  f2 = new GuiFrame(routerB.pos.x,routerB.pos.y);
  
  conn1 = new ArrayList(); conn2 = new ArrayList();
  conn1.add(new PVector(machineA.pos.x, machineA.pos.y));
  conn1.add(new PVector(routerA.pos.x, routerA.pos.y));
  
  conn2.add(new PVector(machineB.pos.x, machineB.pos.y));
  conn2.add(new PVector(routerB.pos.x, routerB.pos.y));
  
  lineAtoRouter.setPath(new ArrayList(conn1));
  lineBtoRouter.setPath(new ArrayList(conn2));
  
  path = new ArrayList();
  path.add(new PVector((width/2 - 150), ( height/2 - 100)));
  path.add(new PVector((width/2 - 150), ( height/2 - 200)));
  path.add(new PVector((width/2 + 150), ( height/2 - 200)));
  path.add(new PVector((width/2 + 150), ( height/2 - 100)));
  
  lineAtoB.setPath(new ArrayList(path));
  
  path2= new ArrayList();
  path2.add(new PVector((width/2 + 150), ( height/2 - 100)));
  path2.add(new PVector((width/2 + 150), ( height/2)));
  path2.add(new PVector((width/2 - 150), ( height/2)));
  path2.add(new PVector((width/2 - 150), ( height/2 - 100)));
  
  lineBtoA.setPath(new ArrayList(path2));
  
  frame.setPath(path);
  f2.setPath(new ArrayList(path2));
  
  components = new ArrayList();
  components.add(lineAtoRouter);
  components.add(lineBtoRouter);
  components.add(machineA);
  components.add(machineB);
  components.add(lineAtoB);
  components.add(lineBtoA);
  components.add(routerA);
  components.add(routerB);
}

void draw(){
  clear();
  background(240);
  
  for (Placeable p: components){
    p.display();
  }
  frame.update();
  if(delay > 0){
    delay--;
  }else{
    f2.update();
  }
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
