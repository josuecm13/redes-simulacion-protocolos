public class ProtocolManager{
  
  /*
    DTO... Variables del estado.
  */
  Protocol protocol;
  DtoManager registryError = new DtoManager();
  
  
  public ProtocolManager(Protocol p){
    this.protocol = p;
    this.protocol.dto = registryError;
  }
  
  void arrived(int index){
    if (isBidirectional(protocol)){
      ((IBidireccional) protocol).receiver(index);
    }else{
      ((IUnidireccional) protocol).receiver();
    }
  }
  
  private Boolean isBidirectional(Protocol protocol){
    return (protocol instanceof ProtocolSlidingWindow); // || (protocol instanceof GoBackN) || (protocol instanceof SelectiveRepeat);
  }
  
  
}
