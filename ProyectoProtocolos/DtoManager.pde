public class DtoManager{
  
  String protocol;
  String kindError;
  Frame frame;
  ArrayList<String> windowInfo = new ArrayList();
  
  /*
  public DtoManager(String protocolo, String tipoError, Frame frame){
    this.protocol = protocolo;
    this.kindErrorr = tipoError;
    this.frame = frame;
  }
  */
  
  public void setProtocol(String p){
    this.protocol = p;
  }
  
  public String getProtocol(){
    return protocol;
  }
  
   public void setKindError(String t){
    this.kindError = t;
  }
  
  public String getKindError(){
    return kindError;
  }
  
  public void setFrame(Frame f){
    this.frame = f;
  }
  
  public Frame getFrame(){
    return frame;
  }
  
  public void setWindowInfo(ArrayList<String> s){
    this.windowInfo = s;
  }
  
  public ArrayList<String> getWindowInfo(){
    return windowInfo;
  }
}
