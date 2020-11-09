/*
Author: Josue Canales Mena
Date: 08/11/2020
*/

public static class GuiManager{
  
  private static final GuiManager instance = new GuiManager();
  
  float _width, _height;
  HashMap<String, Placeable> items;
  HashMap<String, ArrayList<PVector>> connections;
  
  
  private GuiManager(){
    items = new HashMap();
    connections = new HashMap();
  }
  
  public static GuiManager getInstance(){
    return instance;
  }
  
  public void resetProtocol(){
    items = new HashMap();
    connections = new HashMap();
  }
  
  public void connectSimple(String item1, String item2){
    
  }
  
  public void connect(String item1, String item2){
    
  }
  
  public void setDimensions(float w, float h){
    instance._width = w;
    instance._height = h;
  }
  
  
}

public enum GuiComponents{
  MachineA, MachineB, Router, Window
}
