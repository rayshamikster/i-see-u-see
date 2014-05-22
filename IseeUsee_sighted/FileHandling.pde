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

String findAudioFile(int n){
  String thisFile = filenames[n];
  int end = thisFile.length()-4;
  thisFile = thisFile.substring(0,end);
  thisFile+=".3gp";
  //println(thisFile);
  return thisFile;
}

//saves JSON File
void saveFile(String filePath, String data) {
  
  String[] a = {data};
  
  saveStrings(fileLocation + filePath, a); 
}

String openFile(String filePath) {
 File file = new File(fileLocation + filePath);
 String[] s = loadStrings(file.getPath());
 if(s.length == 1)
   return s[0];
 return null;
}
