

void initAPWidget(){
  widgetContainer = new APWidgetContainer(this); //create new container for widgets
  textField = new APEditText(1005, 293, 1277-1005, 403-293); //create a textfield from x- and y-pos., width and height
  widgetContainer.addWidget(textField); //place textField in container
  textField.setInputType(InputType.TYPE_CLASS_TEXT);
  //textField.setHint("Describe here..");
  textField.setImeOptions(EditorInfo.IME_ACTION_DONE); //Enables a Done button
  textField.setCloseImeOnDone(true); //close the IME when done is pressed
  widgetContainer.hide();
}

void onClickWidget(APWidget widget) {  
  if(widget == textField){ 
    comment = textField.getText();
  }
  if(comment==null)
    comment="..";
  comments.add(comment);
  textField.setText(null);
  widgetContainer.hide();
  ((Toggle)cp5.controller("shapeTag")).setState(false);
  ((Toggle)cp5.controller("rectTag")).setState(false);
  writeJSON();
}
