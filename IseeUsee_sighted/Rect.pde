class Rect{
  int w;
  int h;
  PVector position;
  int cornerRadius;
  
  Rect(int posX,int posY,int pw,int ph){
    w=pw;
    h=ph;
    position = new PVector(posX,posY);
    cornerRadius=5;
  }
  
  void drawRect(){
    rect(position.x,position.y,w,h,cornerRadius);
  }
}
