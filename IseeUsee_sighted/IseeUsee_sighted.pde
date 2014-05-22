import ketai.ui.*;
import android.view.MotionEvent;
import controlP5.*;
import android.os.Environment;
import java.io.File;
import apwidgets.*;
import android.text.InputType;
import android.view.inputmethod.EditorInfo;
import android.media.MediaRecorder;
import android.media.MediaPlayer;
import org.json.*;
import java.util.*;
import java.io.*;

ControlP5 cp5;
KetaiGesture gesture;
KetaiVibrate vibe;
APWidgetContainer widgetContainer; 
APEditText textField;
MediaPlayer mPlayer;

float SizeX = 10;
float SizeY = 10;
float Angle = 0;
int prevX=0;
int prevY=0;
PVector position;
boolean rectTag=false;
boolean shapeTag=false;
boolean picsnip=false;
PImage img;
int imgNo=0;
int prevImgNo=0;
int noOfImages;
String comment=" ";
String jsonfile = "IseeUsee.json";
String fileLocation;
PImage topBar;
PImage pic;
boolean playing=false;
ArrayList<PImage> images = new ArrayList<PImage>();
ArrayList<String> comments = new ArrayList<String>();
Rect outline;
ArrayList<Rect> outlines = new ArrayList<Rect>();

org.json.JSONArray out;

String[] filenames;
 
void setup()
{
  orientation(LANDSCAPE);
  size(displayWidth,displayHeight,P2D);
  background(42,42,42);
  gesture = new KetaiGesture(this);
  position=new PVector(0,0);
  cp5 = new ControlP5(this);
  vibe = new KetaiVibrate(this);
  out = new org.json.JSONArray();
  initAPWidget();
  initCP();
  initFile();
  

  
  pic=loadImage(fileLocation+filenames[0]);
  pic.resize(1001,669);
  image(pic,0,83);
  topBar = loadImage("topbar.png");
  image(topBar,0,0);
  textSize(32);
  stroke(255,100);
  strokeWeight(5);
  noFill();
  textAlign(CENTER);
  rectMode(CORNER);
}

void draw()
{
   drawUI();
   drawData();
}

void drawUI() {

  if(imgNo!=prevImgNo){
    pic=loadImage(fileLocation+filenames[imgNo]);
    pic.resize(1001,669);
    image(pic,0,83);
    readJSON();
  }
  prevImgNo=imgNo;
}

 void drawData() {
  if(outlines!=null){
    for(Rect o : outlines){
      //o.drawRect();
    }
  }
}

//void exit(){
//  super.stop();
//}
//
//void onPause(){
//  super.pause();
//}




