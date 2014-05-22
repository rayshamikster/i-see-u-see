
import android.media.MediaRecorder;
import android.media.MediaPlayer;
import android.os.Environment;
import android.content.Context;
import controlP5.*;
import java.io.IOException;
import ketai.camera.*;
MediaRecorder mRecorder;
MediaPlayer mPlayer;


String mFileName = null;
String file=null;
KetaiCamera cam=null;
ControlP5 cp5;
int fileIndex=1;
int time=0;
int prevTime=0;
int speed=100;
int xPos=0;
PImage topBar;
boolean recording=false;

void setup() {
  orientation(LANDSCAPE);
  colorMode(HSB);
  background(0);
  noFill();

  initAudio();
  initControls();
  cam = new KetaiCamera(this, 640, 480, 24);
  cam.setPhotoSize(1024,768);
  topBar=loadImage("topbar.png");
  stroke(241,169,41);
  rect(319,594,640,128);
  speed=(int)20000/(displayWidth-100);
}

void draw() {
  
  drawUI();
  image(cam, 319, 109);
  if(recording){
      rect(40,40,60,60);
      text("Recording...",50,50);
  }
  
  
//  if (recording) {
//    time=millis();
//    if (time-prevTime>speed) {
//      pushMatrix();
//      translate(319,656);
//      float h = random(64);
//      
//      stroke(241,169,41);
//      //line(xPos, h/2, xPos, -h/2);
//      popMatrix();
//      xPos+=2;
//      if (xPos>=959) {
//        xPos=0;
//        fill(42,42,42);
//        rect(displayWidth/2, 3*displayHeight/4+32, displayWidth-100, displayHeight/4);
//      }
//      prevTime=time;
//    }
//  }
}

void drawUI() {
  background(42,42,42);
  image(topBar,0,0);
}


void onCameraPreviewEvent()
{
  cam.read();
}



void onPause() {
  cam.stop();
  cam=null;
  super.onPause();
  if (mRecorder != null) {
    mRecorder.release();
    mRecorder = null;
  }

  if (mPlayer != null) {
    mPlayer.release();
    mPlayer = null;
  }
}

void exit() {
  cam.stop();
  cam=null;
  super.stop();
}

