void initGesture(){
  gesture = new KetaiGesture(this);
}

void onFlick( float x, float y, float px, float py, float v) {
  if(abs(v)>200){  
    ((Toggle)cp5.controller("picsnip")).setState(false);    
    if(rectTag==false && shapeTag==false && mouseOnImage()){
      startPlaying(2);
      if(px>x) {
        imgNo++;
        if(imgNo>=noOfImages)
        imgNo=0;
      }
  
      else{
        imgNo--;
        if(imgNo<0)
        imgNo=noOfImages-1;
      }

      if(playing)
        stopPlaying();
    }
  }  
}

void onDoubleTap(float x, float y){
  if(rectTag==false && shapeTag==false && mouseOnImage()){
    if(!playing){
      startPlaying(1);
     // ((Toggle)cp5.controller("picsnip")).setState(true);    
    }
    else{
      stopPlaying();
      //((Toggle)cp5.controller("picsnip")).setState(false);    
    }
  }
}

public boolean surfaceTouchEvent(MotionEvent event) {

  //call to keep mouseX, mouseY, etc updated
  super.surfaceTouchEvent(event);

  //forward event to class for processing
  return gesture.surfaceTouchEvent(event);
}
