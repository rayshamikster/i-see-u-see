void initAudio() {
  mFileName = Environment.getExternalStorageDirectory().getAbsolutePath();
  mFileName += "/IseeUsee/";
}


//-----------------
//  PLAY
//-----------------
void startPlaying(int type) {

  mPlayer = new MediaPlayer();
  try {
    if(type==1)
      mPlayer.setDataSource(mFileName+"shutter.wav");
    else if(type==2)
      mPlayer.setDataSource(mFileName+"Blip.wav");
    mPlayer.prepare();
    mPlayer.start();
  } 
  catch (IOException e) {
    println("prepare() failed");
  }
}

void stopPlaying() {
  mPlayer.release();
  mPlayer = null;
}

//-----------------
//  RECORD
//-----------------
void startRecording() {
  mRecorder = new MediaRecorder();
  mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
  mRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
  mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
  mRecorder.setMaxDuration(10000);
  mRecorder.setOutputFile(mFileName+file+".3gp");
  fileIndex++;
  try {
    mRecorder.prepare();
  } 
  catch (IOException e) {
    println("prepare() failed");
  }

  mRecorder.start();
}

void stopRecording() {
  mRecorder.stop();
  mRecorder = null;
  //((Toggle)cp5.controller("capture")).setState(false);
}

