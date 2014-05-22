public void writeJSON() {

  try {        
      org.json.JSONObject picData = new org.json.JSONObject();  
      picData.put("id", imgNo);
      picData.put("x-coordinate", outline.position.x); 
      picData.put("y-coordinate", outline.position.y);
      picData.put("width",outline.w );
      picData.put("height", outline.h);
      picData.put("comment",comment);
      out.put(picData);       
    
  } catch (org.json.JSONException e) {
    e.printStackTrace();
  }    
  
  //write data to file
  saveFile(jsonfile, out.toString());
}

public void readJSON() {
  String out_in = openFile(jsonfile);

  // READ JSON 
  try {
  
    org.json.JSONArray in = new org.json.JSONArray(out_in);
    // in is now equal to out
    for(int i = 0; i < in.length(); i++) {
      org.json.JSONObject d = in.getJSONObject(i);      
      int id = d.getInt("id");
      if(id==imgNo){
         String c = d.getString("comment");
         println(c);
         Rect r = new Rect(d.getInt("x-coordinate"),d.getInt("y-coordinate"),d.getInt("width"),d.getInt("height"));
         r.drawRect();
      }
      
     }

              
  } catch (org.json.JSONException e) {
    e.printStackTrace();
  }
  
}


