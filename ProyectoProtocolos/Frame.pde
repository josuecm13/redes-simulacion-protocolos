public class Frame{
  
  int frame_kind;
  int seq; // Secuencia
  int ack; // Confirmacion
  Paquete info;
  
  public Frame(){
    info = new Paquete();
  }
  
  public int getFrame_kind(){
    return frame_kind;
  }
  
  public void setFrame_kind(int frame_kind){
    this.frame_kind = frame_kind;
  }
  
  public int getSeq(){
    return seq;
  }
  
  public void setSeq(int seq){
    this.seq = seq;
  }
  
  public int getAck(){
    return ack;
  }
  
  public void setAck(int ack){
    this.ack = ack;
  }
  
  public Paquete getInfo(){
    return info;
  }
  
  public void setInfo(Paquete info){
    this.info = info;
  }
  
}
