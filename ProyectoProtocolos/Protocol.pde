public abstract class Protocol{
  NetworkLayer networkLayerA;
  PhysicalLayer physicalLayerA;
  
  NetworkLayer networkLayerB;
  PhysicalLayer physicalLayerB;
  
  int checksum;
  int timeout;
  
  int next_frame_to_send;
  int frame_expected;
  DtoManager dto;
  Package buffer;
}
