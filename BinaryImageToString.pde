/**
This program transform an image into a String. The image should be in the jpg format and only contains black and white pixels.
It is think as an extension of the BinaryImageGenerator (https://github.com/Oldbergamot/BinaryImageGenerator).
The result is printed into the console.

How to use :

1) put your image into the program folder
2) set the size in setup according to the file size
3) run the program
*/


PImage toDecypher;            // the image you want to transform into String
PImage toDesplay;             // we use the pixels displayed on the screen to get the ascii value of each char, not the original file
String result= "";            //
String [] binaryAsciiValue;   // contains every ascii value in the form of a binary sequence

void setup() {
  size(225,225);
  toDecypher = loadImage("image.jpg");
  image(toDecypher,0,0);
  loadPixels();
  
  generateBinaryResult();
  generateString();
  
  println(result);
  
  exit();
}

//Return an array of R,G,B value of the given pixel coordonates
public int[] getPixelColor(int x, int y) {
   
  color c = get(x,y);
  int red = (c >> 16) & 0xFF;
  int green = (c >> 8) & 0xFF;
  int blue = c & 0xFF;
  
  return new int[] {red,green,blue};
}

//Return if the pixel is black or white, in other words 0 or 1
public int getPixelValue(int [] array) {
  
  if(array[0]>127 && array[1]>127 && array[2]> 127) return 0;
  return 1;
}

//generate the binary sequence of every char in the image
public void generateBinaryResult() {
  
  binaryAsciiValue = new String[width*height];
  int index = 0;
  int indexTab = 0;
  
  //init tmpResultArray, prevent null pointerExceptions
  for (int i = 0 ; i < binaryAsciiValue.length ; i++) {
    binaryAsciiValue[i] ="";
  }
  
  //generate i
  for (int y = 0 ; y < width ; y++) {
    for (int x = 0 ; x < height ; x++) {
      if(index < 8) {
        int tmp = getPixelValue(getPixelColor(x,y));
        binaryAsciiValue[indexTab]+=String.valueOf(tmp);
        index++;
      } else {
        index = 0;
        indexTab++;
        int tmp = getPixelValue(getPixelColor(x,y));
        binaryAsciiValue[indexTab]+=String.valueOf(tmp);
        index++;
      }      
    }
  }
}

//Transform the binary sequence into the result
public void generateString() {
  int value = 0;
  int a,b,c,d,e,f,g,h;
  for(String s : binaryAsciiValue) {
    if(s==null || s.length() < 8) continue;
    println("s : "+s);
    a = s.charAt(7)==('1')? 1 : 0;
    b = s.charAt(6)==('1')? 2 : 0;
    c = s.charAt(5)==('1')? 4 : 0;
    d = s.charAt(4)==('1')? 8 : 0;
    e = s.charAt(3)==('1')? 16 : 0;
    f = s.charAt(2)==('1')? 32 : 0;
    g = s.charAt(1)==('1')? 64 : 0;
    h = s.charAt(0)==('1')? 128: 0;
    value = a+b+c+d+e+f+g+h;
    result+=Character.toString((char)value);
    println("done");
  }
}
