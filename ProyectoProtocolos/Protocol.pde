public abstract class Protocol{
  NetworkLayer networkLayer;
  PhysicalLayer physicalLayer;
  int checksum;
  int timeout;
  
  int next_frame_to_send;
  int frame_expected;
  DtoManager dto;
  Package buffer;
}
