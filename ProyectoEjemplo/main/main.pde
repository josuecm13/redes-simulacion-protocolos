/*
  ============PARA PROBAR ESTE PROGRAMA============
  
  - Correrlo
  - Para activar las animaciones:
      Tecla "b" o "B": Corre animación de Bob Esponja 
      Tecla "p" o "P" Corre animación de Patricio
      Tecla "1": Corre la animación del Bus
      
  Si el bus choca con Bob o patricio, los saca de la pantalla
  y se puede correr cualquier animación en cualquier Orden
  
  
  CUANDO SE GUARDA EL PROYECTO, SE GUARDA CADA ARCHIVO PERTENECIENTE AL PROYECTO
*/


/*
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
*/
Patricio patrick;
Bob bob;
Bus bus;
PImage bg;

int flag1 = 0;
int flag2 = 0;
int flag3 = 0;

void setup(){
  size(736,476, P2D);
  bg = loadImage("background.jpg");
  patrick = new Patricio(width + 50,height*3/4 ,5);
  bob = new Bob(-50,height*3/4);
  patrick.setLimit(width*1/4);
  bob.setLimit(width*1/8);
  bus = new Bus(width, height*3/5, 15);
  frameRate(27);
  /*oscP5 = new OscP5(this,8080);
  myRemoteLocation = new NetAddress("127.0.0.1",8080);*/
}

void draw(){
  image(bg,0,0);
  if(keyPressed){
    if(key == 'b' || key == 'b'){
      animation1();
    }
    if(key == '1'){
      animation3();
    }
    if(key == 'p' || key == 'P'){
      animation2();
    }
  }
  bob.update();
  patrick.update();
  bus.update();
}

/*
void draw(){
  image(bg,0,0);
  if(flag1 == 1){
    animation1();
    flag1 = 0;
  }
  if(flag3 == 1){
    animation3();
    flag3 = 0;
  }
  if(flag2 == 1){
    animation2();
    flag2 = 0;
  }
  bob.update();
  patrick.update();
  bus.update();
}


void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/test")==true) {
      flag1 = theOscMessage.get(0).intValue();  
      flag2 = theOscMessage.get(1).intValue();
      flag3 = theOscMessage.get(2).intValue();
      if(flag1 == 1){
        animation1();
      }else if(flag2 == 1){
        animation2();
      }else if(flag3 == 1){
        animation3();
      }
  } else {
    println("received unrecognized osc message");
  }
}
*/
void animation1(){
  bus.subscribeVictim((HittableByCar) bob);
  bob.move();
}

void animation2(){
  bus.subscribeVictim((HittableByCar) patrick);
  patrick.move();
}

void animation3(){
  bus.move();
}
