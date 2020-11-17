public class ProtocoloManager{
  
  /*
    DTO... Variables del estado.
  */
  Protocolo protocolo;
  
  public ProtocoloManager(Protocolo p){
    this.protocolo = p;
  }
  
  void arrived(int index){
    if (isBidirectional(protocolo)){
      ((IBidireccional) protocolo).receiver(index);
    }else{
      ((IUnidireccional) protocolo).receiver();
    }
  }
  
  private Boolean isBidirectional(Protocolo protocol){
    return false;
    //return (protocol instanceof SlidingWindow) || (protocol instanceof GoBackN) || (protocol instanceof SelectiveRepeat);
  }
  
  
  
  
  
 
}
