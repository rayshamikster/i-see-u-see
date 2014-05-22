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
  ((Toggle)cp5.controller("picsnip")).setState(false);
}
