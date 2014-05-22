void initControls(){
  cp5 = new ControlP5(this);  
  PImage captureOff = loadImage("captureOff.png");
  PImage captureOn = loadImage("captureOn.png");
  PImage onCameraOff = loadImage("onCameraOff.png");
  PImage onCameraOn = loadImage("onCameraOn.png");
  cp5.addToggle("capture")
     .setPosition(displayWidth-210,displayHeight/2)
     .setSize(128,128)
     .setImages(captureOff,captureOff,captureOn)
     ;
     
  cp5.addToggle("onCamera")
     .setPosition(182,593)
     .setSize(200,200)
     .setImages(onCameraOff,onCameraOff,onCameraOn)
     ;
}


void onCamera() {
    if (cam.isStarted())
    {
      cam.stop();
    }
    else
      cam.start();
}

void capture(boolean theValue) {
  
  if(theValue){
    file = "iseeusee_"+year()+month()+day()+hour()+minute()+second();
    cam.savePhoto(mFileName+file+".jpg");
    startPlaying(1);
    startRecording();
  }
  else
    stopRecording();
    startPlaying(2);
}

