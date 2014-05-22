
import android.content.Context;
import android.speech.tts.TextToSpeech;
import android.speech.tts.TextToSpeech.OnInitListener;
import android.speech.tts.TextToSpeech.Engine;
import android.speech.RecognizerIntent;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import java.util.Locale;
import android.os.Environment;
import java.io.File;
import org.json.*;
import java.util.*;
import java.io.*;
import android.media.MediaPlayer;
import ketai.ui.*;
import android.view.MotionEvent;



// We implement directly the texttospeech listener into the processing PApplet class
public class Blindstream extends PApplet implements TextToSpeech.OnInitListener 
{

  // we need this for an obscure reason;
  int VOICE_RECOGNITION_REQUEST_CODE = 1234;

  // The text to speech object
  private TextToSpeech mTts;
  int MY_DATA_CHECK_CODE = 0;

  ArrayList<String[]>comments = new ArrayList<String[]>();
  ArrayList<PImage> pictures = new ArrayList<PImage>();
  ArrayList<Rect>currentOutlines;
  ArrayList<String>currentComments;
  ArrayList<Rect> rectangles = new ArrayList<Rect>();
  KetaiGesture gesture;
  MediaPlayer mPlayer;
  MediaPlayer earconPlayer;
  PImage pic;
  PImage topBar;
  PImage bottomNav;
  int out=0;
  int in=1;
  int enterState=0;
  int prevEnterState=0;
  boolean mouseEnterState = false;
  String fileLocation;
  String jsonfile = "IseeUsee.json";
  String comm = null;
  String prevComm = null;
  String[] filenames;
  int imgNo=0;
  int prevImgNo=0;
  int noOfImages;
  boolean playing = false;
  KetaiVibrate vibe;
  void setup() { 
    gesture = new KetaiGesture(this);
    vibe = new KetaiVibrate(this);
    initFile();
    background(42,42,42);
    println(fileLocation);
    pic=loadImage(fileLocation+filenames[0]);
    image(pic, 136, 0, 1008, 674);
//    topBar = loadImage("topbar.png");
//    image(topBar, 0, 0);
    bottomNav = loadImage("bottomNavBlind.png");
    image(bottomNav, 0, displayHeight-78);
    initTTS();
    noFill();
    stroke(230, 100);
    strokeWeight(5);
    gesture = new KetaiGesture(this);
  }

  void draw() {
    if (imgNo!=prevImgNo) {
      pic=loadImage(fileLocation+filenames[imgNo]);
      //pic.resize(1280,752);
      background(42,42,42);
      image(pic, 136, 0, 1008, 674);
      image(bottomNav, 0, displayHeight-78);
      //image(topBar, 0, 0);
      readJSON();
    }
    prevImgNo=imgNo;
    if (currentOutlines!=null && currentComments!=null) {
      for (int i=0;i<currentOutlines.size();i++) {
        if (mouseEnter(currentOutlines.get(i))) {
          pushMatrix();
          translate(136,-83);
          stroke(230, 255);
          scale(1008/1001);
          (currentOutlines.get(i)).drawRect();
          popMatrix();
          comm = (currentComments.get(i));
          if (comm!=prevComm)
            speakComments(comm);

          //println(comments.get(i));
        }
      }
    }
  }

  void mouseDragged()
  {
    if (mouseOnEdge())    //vibrates on the edge for slower mouse movements
      vibe.vibrate(100);
  }

boolean mouseOnEdge() {
  if(((mouseX>136 && mouseX<156) || (mouseX>1124 && mouseX<1144)) && mouseY<674)
    return true;
  else if(((mouseY>0 && mouseY<20) || (mouseY>654 && mouseY<674)) && (mouseX>136 && mouseX<1144))
    return true;
  else
    return false;
}

  void initFile() {
    fileLocation = Environment.getExternalStorageDirectory().getAbsolutePath();
    fileLocation+="/IseeUsee/";
    filenames = loadFilenames(fileLocation);
    println(filenames);
    noOfImages = filenames.length;
  }


  String[] loadFilenames(String path) {
    java.io.File folder = new java.io.File(path);
    java.io.FilenameFilter filenameFilter = new java.io.FilenameFilter() {
      public boolean accept(File dir, String name) {
        return name.toLowerCase().endsWith(".jpg"); // change this to any extension you want
      }
    };
    return folder.list(filenameFilter);
  }

  void startPlaying(int type) {

    mPlayer = new MediaPlayer();
    try {
      if(type==1)
        mPlayer.setDataSource(fileLocation+findAudioFile(imgNo));
      else if(type==2)
        mPlayer.setDataSource(fileLocation+"beep.wav");
      mPlayer.prepare();
      mPlayer.start();
      playing=true;
    } 
    catch (IOException e) {
      println("prepare() failed");
    }
  }

  void stopPlaying() {
    mPlayer.release();
    mPlayer = null;
    playing=false;
  }

  String findAudioFile(int n) {
    String thisFile = filenames[n];
    int end = thisFile.length()-4;
    thisFile = thisFile.substring(0, end);
    thisFile+=".3gp";
    return thisFile;
  }

  public void readJSON() {
    String out_in = openFile(jsonfile);

    // READ JSON 
    try {

      org.json.JSONArray in = new org.json.JSONArray(out_in);
      // in is now equal to out
      currentOutlines=new ArrayList<Rect>();
      currentComments = new ArrayList<String>();
      for (int i = 0; i < in.length(); i++) {
        org.json.JSONObject d = in.getJSONObject(i);      
        int id = d.getInt("id");
        if (id==imgNo) {
          String c = d.getString("comment");
          currentComments.add(c);
          Rect r = new Rect(d.getInt("x-coordinate"), d.getInt("y-coordinate"), d.getInt("width"), d.getInt("height"));
          pushMatrix();
          translate(136,-83);
          stroke(230, 100);
          scale(1008/1001);
          r.drawRect();
          popMatrix();
          currentOutlines.add(r);
        }
      }
    } 
    catch (org.json.JSONException e) {
      e.printStackTrace();
    }
  }

  String openFile(String filePath) {
    File file = new File(fileLocation + filePath);
    String[] s = loadStrings(file.getPath());
    if (s.length == 1)
      return s[0];
    return null;
  }

  void speakComments(String whatToSay) { 
    if (!mTts.isSpeaking()) {
      speak(whatToSay);
      prevComm = whatToSay;
    }
  }

  private void initTTS() {
    Intent checkIntent = new Intent();
    checkIntent.setAction(TextToSpeech.Engine.ACTION_CHECK_TTS_DATA);
    startActivityForResult(checkIntent, MY_DATA_CHECK_CODE);
  }

  // make sure we know what to do when
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == MY_DATA_CHECK_CODE) {

      if (resultCode == TextToSpeech.Engine.CHECK_VOICE_DATA_PASS) {
        mTts = new TextToSpeech(this, this);
      }
    }
  }

  void speak(String toSpeak) {
    mTts.speak(toSpeak, TextToSpeech.QUEUE_FLUSH, null);
  }

  public void onInit(int status) {
    if (status == TextToSpeech.SUCCESS) {
      int result = mTts.setLanguage(new Locale("en"));

      if (result == TextToSpeech.LANG_MISSING_DATA) {
        println(" LANG MISSING ");
      }  
      else if (result == TextToSpeech.LANG_NOT_SUPPORTED) {
        println(" LANG NOT SUPPORTED ");
      }
    } 
    else {
      // Initialization failed.
      println("Could not initialize TextToSpeech.");
    }
  }

  void onFlick( float x, float y, float px, float py, float v) {
    if (abs(v)>150) {
 
        startPlaying(2);

      if (px>x) {
        imgNo++;
        if (imgNo>=noOfImages)
          imgNo=0;
      }

      else {
        imgNo--;
        if (imgNo<0)
          imgNo=noOfImages-1;
      }
    }
  }

  void onDoubleTap(float x, float y) { 
      if (!playing) 
        startPlaying(1);
      else
        stopPlaying();
  }
  public boolean surfaceTouchEvent(MotionEvent event) {

    //call to keep mouseX, mouseY, etc updated
    super.surfaceTouchEvent(event);

    //forward event to class for processing
    return gesture.surfaceTouchEvent(event);
  }

  boolean mouseEnter(Rect r) {
    if (r.position.x+136<mouseX && (r.position.x+r.w+136)>mouseX) {
      if (r.position.y-83<mouseY && (r.position.y+r.h-83)>mouseY)
        enterState=in;
      else
        enterState=out;
    }
    else
      enterState=out;

    if (enterState==in && prevEnterState==out)
      mouseEnterState=true;
    else
      mouseEnterState=false;
    prevEnterState=enterState;
    println("mouseEnterState: " +mouseEnterState);
    return mouseEnterState;
  }

  class Rect {
    int w;
    int h;
    PVector position;

    Rect(int posX, int posY, int pw, int ph) {
      w=pw;
      h=ph;
      position = new PVector(posX, posY);
    }

    void drawRect() {
      rect(position.x, position.y, w, h, 5);
    }
  }
}

