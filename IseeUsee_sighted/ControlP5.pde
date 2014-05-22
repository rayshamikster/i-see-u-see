void initCP(){
  PImage rectTagOff = loadImage("rectTagOut.png");
  PImage rectTagOn = loadImage("rectTagIn.png");
  PImage shapeTagOff = loadImage("shapeTagOut.png");
  PImage shapeTagOn = loadImage("shapeTagIn.png");
  PImage likeOff = loadImage("likeOut.png");
  PImage likeOn = loadImage("likeIn.png");
  PImage nextOff = loadImage("nextOut.png");
  PImage nextOn = loadImage("nextIn.png");
  PImage prevOff = loadImage("prevOut.png");
  PImage prevOn = loadImage("prevIn.png");
  PImage picsnipOn = loadImage("picsnipOn.png");
  PImage picsnipOff = loadImage("picsnipOff.png");  
  cp5.addToggle("like")
     .setPosition(1005,83)
     .setSize(100,60)
     .setImages(likeOff,likeOff,likeOn)
     ;
  
  cp5.addToggle("rectTag")
     .setPosition(1005,182)
     .setSize(100,60)
     .setImages(rectTagOff,rectTagOff,rectTagOn)
     ;
  cp5.addToggle("shapeTag")
     .setPosition(1143,182)
     .setSize(100,60)
     .setImages(shapeTagOff,shapeTagOff,shapeTagOn)
     ;
  cp5.addToggle("picsnip")
     .setPosition(80,120)
     .setSize(100,100)
     .setImages(picsnipOff,picsnipOff,picsnipOn)
     ;
  cp5.addButton("next")
     .setPosition(551,658)
     .setSize(100,60)
     .setImages(nextOff,nextOff,nextOn)
     ;
  cp5.addButton("previous")
     .setPosition(410,658)
     .setSize(100,60)
     .setImages(prevOff,prevOff,prevOn)
     ;

}


void next(boolean theValue){
  if(!shapeTag && !rectTag){
    ((Toggle)cp5.controller("picsnip")).setState(false);    
    startPlaying(2);
    imgNo++;
    if(imgNo>=noOfImages)
    imgNo=0;
  }
}

void previous(boolean theValue){
  if(!shapeTag && !rectTag){
    ((Toggle)cp5.controller("picsnip")).setState(false);    
    startPlaying(2);
    imgNo--;
    if(imgNo<0)
    imgNo=noOfImages-1;
 }
}

void picsnip(boolean theValue){
  if(theValue){
  if(!rectTag && !shapeTag){
      startPlaying(1);
    }
  }
}

  
  
