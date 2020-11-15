/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public enum GuiComponents{
  MachineA, MachineB, RouterA, RouterB, Frame, Window
}

public class GuiManager{
  
  float _width, _height;
  ArrayList<Placeable> allComponents;
  ArrayList<Placeable> showing;
  int windowSize, refreshRate;
  float pErrorChecksum, pErrorPacket;
  
  public GuiManager(float w, float h){
    this._width = w;
    this._height = h;
    this.refreshRate = 30;
    allComponents = new ArrayList();
    showing = new ArrayList();
    initComponents();
  }
  
  public GuiManager(float w, float h, ArrayList<GuiComponents> components){
    this._width = w;
    this._height = h;
    this.refreshRate = 30;
    allComponents = new ArrayList();
    showing = new ArrayList();
    initComponents(components);
  }
  
  public void initComponents(ArrayList<GuiComponents> components){
    for(GuiComponents c: components){
      allComponents.add(createComponent(c));
    }
    makeConnections();
  }
  
  public void initComponents(){
    ArrayList<GuiComponents> components = new ArrayList();
    components.add(GuiComponents.MachineA);
    components.add(GuiComponents.RouterA);
    components.add(GuiComponents.MachineB);
    components.add(GuiComponents.RouterB);
    initComponents(components);
  }
  
  public void display(){
    for(Placeable p: showing){
      p.display();
    }
  }
  
  public void setDimensions(float w, float h){
    this._width = w;
    this._height = h;
  }
  
  public void resetProtocol(){
    allComponents = new ArrayList();
    showing = new ArrayList();
  }
  
  public void HideComponent(GuiComponents comp, int index){
    for (Placeable c: showing){
      if(isType(c, comp)){
        if( index != 0 ){
          index --;  
        }else{
          showing.remove(c);
        }
      }
    }
  }
  
  public void start(){
    for(Placeable p: allComponents){
      if(!isType(p, GuiComponents.Frame))
        showing.add(p);
    }
  }
  
  public void showComponent(GuiComponents comp, int index){
    for (Placeable c: allComponents){ //<>//
      if(isType(c, comp)){
        if( index != 0 ){
          index --;  
        }else{
          ((GuiFrame) c).play(true);
          showing.add(c);
        }
      }
    }
  }
  
  public void play(){
    for (Placeable c: showing){
      if(isType(c, GuiComponents.Frame)){
        ((GuiFrame) c).play(true);
        showing.add(c);
      }
    }
  }  
  
  
  /* 
  
  
      ---------------------PRIVATE FUNCTIONS ---------------------------------
  
  
  */
  private void makeConnections(){
    Placeable mA = findWhereWidthLessThan(GuiComponents.MachineA, (int) _width/2);
    Placeable rA = findWhereWidthLessThan(GuiComponents.RouterA, (int) _width/2);
    Placeable mB = findWhereWidthLessThan(GuiComponents.MachineB, (int) _width);
    Placeable rB = findWhereWidthLessThan(GuiComponents.RouterB, (int) _width);
    
    connectSimple(rB, mB);
    connect(rA, rB);
    connectSimple(mA, rA);
    /* Extras
    if (is Bidirectional){
      connect(rB, rA);
    }
    */
  }
  
  private void connectSimple(Placeable item1, Placeable item2){
    ArrayList<PVector> path = new ArrayList();
    path.add( new PVector(item1.pos.x, item1.pos.y));
    path.add( new PVector(item2.pos.x, item2.pos.y));
    GuiPath guiP = new GuiPath(path);
    this.allComponents.add(0, guiP);
  }
  
  private void connect(Placeable item1, Placeable item2){
    ArrayList<PVector> path = new ArrayList();
    int offset = + 100;
    if( item1.pos.x < item2.pos.x ){
      offset *= -1;
    }
    path.add( new PVector(item1.pos.x, item1.pos.y));
    path.add( new PVector(item1.pos.x, item1.pos.y + offset ));
    path.add( new PVector(item2.pos.x, item1.pos.y + offset ));
    path.add( new PVector(item2.pos.x, item2.pos.y));
    GuiPath guiP = new GuiPath(new ArrayList(path));
    GuiFrame frame;
    if(offset < -1){
      frame = (GuiFrame)findWhereWidthLessThan(GuiComponents.Frame,(int) _width/2);
    }else{
      frame = (GuiFrame)findWhereWidthLessThan(GuiComponents.Frame,(int) _width);
    }
    
    frame.setPath(path);
    
    this.allComponents.add(0, guiP);
  }
  
  private Placeable findWhereWidthLessThan(GuiComponents comp, int w){
    for (Placeable p: allComponents){
      if( p.pos.x > w ){
        continue;
      }
      if(isType(p,comp) && p.pos.x > w - _width/2){
        return p;      
      }
    }/*
    int len = allComponents.size() -1;
    for(int i = len; i > 0; i--){
      Placeable temp= allComponents.get(i);
      if( temp.pos.x > w ){
        continue;
      }
      if(isType(temp,comp) && temp.pos.x > w - _width/2){
        return temp;      
      }
    }*/
    return null;
  }
  
  private Boolean isType(Placeable object , GuiComponents type){
    if(type == GuiComponents.MachineA || type == GuiComponents.MachineB){
      return object instanceof GuiMachine;
    }else if(type == GuiComponents.RouterA || type == GuiComponents.RouterB){
      return object instanceof GuiRouter;
    }else if(type == GuiComponents.Frame){
      return object instanceof GuiFrame; /* TODO: GuiWindow*/
    }else if(type == GuiComponents.Window){
      return false; /* TODO: GuiWindow */
    }
    return false;
  }
  
  private Placeable createComponent(GuiComponents type){
    if(type == GuiComponents.MachineA){
      return new GuiMachine((_width/2 - 300),(_height/2 - 150), MachineType.A); 
    }if(type == GuiComponents.MachineB){
      return new GuiMachine((_width/2 + 300),(_height/2 - 50), MachineType.B);
    }else if(type == GuiComponents.RouterA){
      return new GuiRouter((_width/2 - 150),(_height/2 - 150));
    }else if(type == GuiComponents.RouterB){
      return new GuiRouter((_width/2 + 150),(_height/2 - 50));
    }else if(type == GuiComponents.Frame){
      return new GuiFrame((_width/2 - 150),(_height/2 - 150));
    }else if(type == GuiComponents.Window){
      // 
    }  
    return null;
  }
  
}
