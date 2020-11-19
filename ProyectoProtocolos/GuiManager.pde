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
  Boolean inMenu, isBidirectional;
  ArrayList<TextBox> settings;
  int indexMachine = 0;
  
  ProtocolManager pm;
  
  public GuiManager(float w, float h){
    this._width = w;
    this._height = h;
    this.refreshRate = 30;
    this.inMenu =true;
    this.isBidirectional = false;
    allComponents = new ArrayList();
    showing = new ArrayList();
    settings = new ArrayList();
    initComponents();
  }
  
  public GuiManager(float w, float h, ArrayList<GuiComponents> components){ //<>//
    this._width = w; //<>//
    this._height = h;
    this.refreshRate = 30;
    this.inMenu =true;
    this.isBidirectional = false;
    allComponents = new ArrayList();
    showing = new ArrayList();
    settings = new ArrayList();
    initComponents(components);
  }
  
  public void initComponents(ArrayList<GuiComponents> components){
    int cont = -1;
    for(GuiComponents c: components){
      if(c == GuiComponents.Frame){
        cont++;
      }
      allComponents.add(createComponent(c, cont));
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
    if(inMenu){
      for(TextBox t: settings){
        t.DRAW();
      }
    }else{
      for(Placeable p: showing){
        if(isType(p, GuiComponents.Frame)){
          if(((GuiFrame) p).arrived == true){
            println("ESTADO ACTUAL:");
            if(isBidirectional){
              // Notificar al ProcolManager que el paquete ya llego
              pm.arrived(indexMachine);
              /*GuiFrame f; //<>//
              if(indexMachine == 0){
                f = (GuiFrame) findWhereWidthLessThan(GuiComponents.Frame,(int) _width/2);
              }else{
                f = (GuiFrame) findWhereWidthLessThan(GuiComponents.Frame,(int) _width);
              }
              f.displaying = false;*/
              ((GuiFrame) p).displaying=false;
              ((GuiFrame) p).play(false);
              indexMachine = (indexMachine+1)%2;
              print(indexMachine);
              gui.displayFrame(indexMachine);
            }else{
              pm.arrived(0);
              gui.displayFrame(0);
            }
            /*
            String protocol;
            String kindError;
            Frame frame;
            */
            
            ((GuiFrame) p).arrived = false;/*
            println("Protocolo: ", pm.registryError.getProtocol());
            println("Tipo de Error: ", pm.registryError.getKindError());
            println("------------FRAME------------");
            println("Paquete:", pm.registryError.getFrame().getInfo().getData());
            println("FrameInfo: Secuencia(", pm.registryError.getFrame().getSeq() ,").. Acknowledge(", pm.registryError.getFrame().getAck() ,")");*/
            //pm.registryError
          }
        }
        p.display();
      }
    } //<>//
  }
  
  public void setDimensions(float w, float h){
    this._width = w;
    this._height = h;
  }
  
  public void resetProtocol(){
    allComponents = new ArrayList();
    showing = new ArrayList();
  }
  
  public void hideComponent(GuiComponents comp, int index){
    for (Placeable c: showing){
      if(isType(c, comp)){
        if( index != 0 ){
          index --;  
        }else{
          int i = showing.indexOf(c);
          showing.remove(i);
          return;
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
          index --;   //<>//
        }else{
          ((GuiFrame) c).play(true);
          showing.add(c);
          break;
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
  
  public void displayFrame(int index){
    print("Show Frame - ");
    for (Placeable c: showing){
      if(isType(c, GuiComponents.Frame)){
        if( index != 0 ){
          index --;  
        }else{
          ((GuiFrame) c).play(true);
        }
      }
    }
  }
  
  public void setProtocol(int index, int checksum, int timeout){
    switch(index){
      case 1:{
        pm = new ProtocolManager(new ProtocolUtopia()); //<>//
        showComponent(GuiComponents.Frame,0);
        break;
      }case 2:{
        pm = new ProtocolManager(new ProtocolStopAndWait());
        showComponent(GuiComponents.Frame,0);
        break;
      }case 3:{
        pm = new ProtocolManager(new ProtocolPar(checksum, timeout));
        showComponent(GuiComponents.Frame,0);
        break;
      }case 4:{
        this.isBidirectional = true;
        pm = new ProtocolManager(new ProtocolSlidingWindow(checksum, timeout));
        showComponent(GuiComponents.Frame,0);
        showComponent(GuiComponents.Frame,1);
        GuiFrame f = (GuiFrame) findWhereWidthLessThan(GuiComponents.Frame,(int) _width);
        f.displaying = false;
        break;
      }/*case 5:{
      
      }case 6:{
        this.isBidirectinal = true;
      
      }*/default:{
        pm = new ProtocolManager(new ProtocolUtopia());
        showComponent(GuiComponents.Frame,0);
      }
    }
    // 
  }
  
  
  public void menuMode(){
    this.inMenu = true;
    
    if(settings.isEmpty()){
      /* 
        Tipo de protocolo 
        Checksum Error % 
        TimeOut %
        Velocidad: 12 - 70 fps
      */
      TextBox protype = new TextBox(_width/4, _height/4, 150, 30, "Protocolo {1...6}");
      TextBox checksumError = new TextBox(_width/4 + 250, _height/4, 150, 30, "Checksum Error % (0-100)");
      TextBox timeoutError = new TextBox(_width/4 + 500, _height/4, 150, 30, "Timeout Error % (0-100)");
      TextBox velocidad = new TextBox(_width/4, _height/4 + 70, 150, 30, "Velocidad {12...200}");
      
      TextBox buttonConfirm = new TextBox(_width/2 - 10,  _height/2, 250, 40);
      buttonConfirm.Text = "\tEmpezar simulación";
      buttonConfirm.TEXTSIZE = 24;
      settings.add(protype);
      settings.add(checksumError);
      settings.add(timeoutError);
      settings.add(velocidad);
      settings.add(buttonConfirm);
    }
    
    
  }
  
  public Boolean submitChanges(){
    // Toma el Array settings
    // Convierte el texto en variables
    if(inMenu){
      this.inMenu = false;
      /* 
        Tipo de protocolo 
        Checksum Error % 
        TimeOut %
        Velocidad: 12 - 70 fps
      */
      
      int tipoProtocolo = Integer.parseInt(settings.get(0).Text);
      int checksum = Integer.parseInt(settings.get(1).Text);
      int timeout = Integer.parseInt(settings.get(2).Text);
      int velocidad = Integer.parseInt(settings.get(3).Text);
      
      frameRate(velocidad);
      
      this.start();
      setProtocol(tipoProtocolo, checksum, timeout);
      
    }else{
    
    }
    return true;
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
    connect(rB, rA);
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
    frame.setParent(this);
    
    this.allComponents.add(0, guiP);
  }
  
  
  private void setSettings(){
    //Setea la configuración en 
  }
  
  
  
  private Placeable findWhereWidthLessThan(GuiComponents comp, int w){
    for (Placeable p: allComponents){
      if( p.pos.x > w ){
        continue;
      }
      if(isType(p,comp) && p.pos.x > w - _width/2){ //<>//
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
  
  private Placeable createComponent(GuiComponents type, int cont){
    if(type == GuiComponents.MachineA){
      return new GuiMachine((_width/2 - 300),(_height/2 - 150), MachineType.A); 
    }if(type == GuiComponents.MachineB){
      return new GuiMachine((_width/2 + 300),(_height/2 - 50), MachineType.B);
    }else if(type == GuiComponents.RouterA){
      return new GuiRouter((_width/2 - 150),(_height/2 - 150));
    }else if(type == GuiComponents.RouterB){
      return new GuiRouter((_width/2 + 150),(_height/2 - 50));
    }else if(type == GuiComponents.Frame){
      if(cont == 0){
        return new GuiFrame((_width/2 - 150),(_height/2 - 150));
      }else{
        return new GuiFrame((_width/2 + 150),(_height/2 + 150));
      }
    }else if(type == GuiComponents.Window){
      // 
    }  
    return null;
  }
  
}
