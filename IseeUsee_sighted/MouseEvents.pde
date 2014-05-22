void mousePressed(){
  if(rectTag && mouseOnImage()){
    prevX=mouseX;
    prevY=mouseY;
  }
}

void mouseDragged()
{
  
  if(mouseOnEdge())    //vibrates on the edge for slower mouse movements
    vibe.vibrate(100);
}

void mouseReleased(){
  if(rectTag && mouseOnImage()){
    SizeX=mouseX-prevX;
    SizeY=mouseY-prevY;
    outline = new Rect(prevX,prevY,(int)SizeX,(int)SizeY);
    outline.drawRect();
    outlines.add(outline);
    widgetContainer.show();
   }
   
}

boolean mouseOnImage(){
  if(mouseX<1001 && mouseY>83)
    return true;
    
  else
    return false;
}

boolean mouseOnEdge() {
  if(((mouseX>0 && mouseX<20) || (mouseX>981 && mouseX<1001)) && mouseY>83)
    return true;
  else if(((mouseY>83 && mouseY<103) || (mouseY>732 && mouseY<752)) && mouseX<1001)
    return true;
  else
    return false;
}





