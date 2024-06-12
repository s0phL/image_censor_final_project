PImage img, imgCopy;
PImage img2;
PImage pixelizeIcon;
PGraphics pg; //so Restore class can edit pg created in Draw class
PGraphics imgArea; 
Selection selectionTool;
Draw drawTool;
int penSize = 5;
private Button btn1, btn2, btn3;
private CircleOnBtn btn4, btn5, btn6, btn7, btn8;
Button[] btnArray = new Button[8];
CircleOnBtn[] penSizeBtns = new CircleOnBtn[5];
Slider slide;

int leftCenterW; //x pos of left side of img so it is in the center
int leftCenterH; //y pos of left side of img so it is in the center

int zoomSize = 2;
int zoomCount = 0;
double thingX; // image centered at mouse x
double thingY; 

int xStart;
int yStart;

void setup() {
  size(1000, 500);
  
  try {
    String image_path = input.getString("Enter image path");
    insertImage(image_path);
  } 
  catch (NullPointerException e) { //defaults to bird.jpg if user input
    String image_path = "bird.jpg";
    //image_path = input.getString("Invalid path. Please try again");
    insertImage(image_path);
  }
  
  /*
   println(img.width); //342
   println(img.height); //400
   println(img.pixels.length); //136800
   println(img.height % 3); //1 
  */
   
   selectionTool = new Selection("none");
   drawTool = new Draw();
   
   pixelizeIcon = loadImage("assets/pixelize.png");
   pixelizeIcon.resize(50, 50);
   image(pixelizeIcon, 76-pixelizeIcon.width-10, 100);
   
   btn1 = new Button(76, 100, 100, 60, 5, "Pixelate", 25, 255, "pixelate");
   btnArray[0] = btn1;
   btn2 = new Button(76, 200, 100, 60, 5, "Draw", 25, 255, "draw");
   btnArray[1] = btn2;
   btn3 = new Button(76, 300, 100, 60, 5, "Download", 25, 255, "download");
   btnArray[2] = btn3;
   
   /* appears on draw. changes pen size */
   btn4 = new CircleOnBtn(225, 150, 30, 30, 5, "", 25, 255, "penChange", 25);
   btnArray[3] = btn4;
   penSizeBtns[0] = btn4;
   btn5 = new CircleOnBtn(225, 190, 30, 30, 5, "", 25, 255, "penChange", 20);
   btnArray[4] = btn5;
   penSizeBtns[1] = btn5;
   btn6 = new CircleOnBtn(225, 230, 30, 30, 5, "", 25, 255, "penChange", 15);
   btnArray[5] = btn6;
   penSizeBtns[2] = btn6;
   btn7 = new CircleOnBtn(225, 270, 30, 30, 5, "", 25, 255, "penChange", 10);
   btnArray[6] = btn7;
   penSizeBtns[3] = btn7;
   btn8 = new CircleOnBtn(225, 310, 30, 30, 5, "", 25, 255, "penChange", 5);
   btnArray[7] = btn8;
   penSizeBtns[4] = btn8;
   
   /* appears on pixelate. adjusts pixelization amount */
   slide = new Slider(225, 150, 10, 200, 3, 25);
  
}

void insertImage(String image_path) {
  println("image path: " + image_path);
  
  img = loadImage(image_path);
  imgCopy = loadImage(image_path); //img to reference when restoring edited img
  img2 = loadImage(image_path);
  while (img.width > width || img.height > height) {
    imgCopy.resize(img.width/2, img.height/2);
    img2.resize(img.width/2, img.height/2);
    img.resize(img.width/2, img.height/2);
    
  }
  
  leftCenterW = (width - img.width) / 2;
  leftCenterH = (height - img.height) / 2;
  
  imgArea = createGraphics(img.width, img.height);
  imgArea.beginDraw();
  imgArea.pushMatrix();
  imgArea.translate(-leftCenterW, -leftCenterH); //move imgArea pos to img pos
  imgArea.image(img, leftCenterW, leftCenterH);
  imgArea.popMatrix();
  imgArea.endDraw();
  
  thingX = leftCenterW;
  thingY = leftCenterH;
  
  println(leftCenterW, leftCenterH);
  
  //image(img, leftCenterW, leftCenterH); // place image at center of screen
  
}

void draw() {
  background(13, 21, 28);
  image(pixelizeIcon, 76-pixelizeIcon.width-10, 100);
  //image(img, leftCenterW, leftCenterH); // place image at center of screen again
  image(imgArea, leftCenterW, leftCenterH); // place image at center of screen again
  
  //confineImg();
  
  selectionTool.draw();
  for (Button btn : btnArray) {
    btn.draw();
  }
  slide.draw();
  //println(mouseX, mouseY);
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    xStart = mouseX;
    yStart = mouseY;
  }
  selectionTool.mousePressed();
  drawTool.mousePressed();
  slide.mousePressed();
}

void mouseDragged() {
  if (mouseButton == RIGHT) {
    imgArea.beginDraw();
    imgArea.background(240);
    //thingX-leftCenterW, (float)thingY-leftCenterH
    imgArea.image(img, (float)thingX-leftCenterW+(mouseX-xStart), (float)thingY-leftCenterH+(mouseY-yStart));
    imgArea.endDraw();
  }
  
  selectionTool.mouseDragged();
  drawTool.mouseDragged();
  for (Button btn : btnArray) {
    btn.mouseDragged();
  }
  slide.mouseDragged();
}

void mouseReleased() {
  selectionTool.mouseReleased();
  for (Button btn : btnArray) {
    btn.mouseReleased();
  }
  if (mouseButton == RIGHT) {
    thingX += (mouseX-xStart);
    thingY += (mouseY-yStart);
  }
  else {
    //resetImgQuality();
    //confineImg();
  }
  
  //imgArea.save("imgArea.png");
}

void keyPressed() {
  drawTool.keyPressed();  
  /* //Maybe try this later with alt user input setup (b/c right now image_path is null//
  if (key == 'b') {
    img = loadImage(image_path); 
  }
  */
  if (key=='7') {
    pg.save("pg.png");
    img2.save("img2.png");
  }
  if(key=='1')println(mouseX, mouseY);
  
  if (key == 'r') { //reset image
    zoomCount = 0;
    xStart = 0;
    yStart = 0;
    thingX = leftCenterW;
    thingY = leftCenterH;
    img = imgCopy.get(0, 0, imgCopy.width, imgCopy.height);
    confineImg();
  }
  if (key == '4') { //reset settings
    penSize = 5;
    slide.indicatorPos = 152;
    zoomCount = 0;
    xStart = 0;
    yStart = 0;
    thingX = leftCenterW;
    thingY = leftCenterH;
    img = img2.get(0, 0, img2.width, img2.height);
    confineImg();
    
    /*
    resetImgQuality();
    imgArea.beginDraw();
    imgArea.image(img, 0, 0);
    imgArea.endDraw();
    */
  }
  
  if (key == 'q' && zoomCount < 3) { //zoom in
    img.resize(img.width*zoomSize, img.height*zoomSize);
    zoomCount++;
    println("Q:" + zoomCount);
    //thingX = (mouseX*((int)(Math.pow(zoomSize, zoomCount)))-mouseX-leftCenterW);
    //thingY = (mouseY*((int)(Math.pow(zoomSize, zoomCount)))-mouseY-leftCenterH);
    
    /*
    println((thingX)+mouseX);
    println(leftCenterW-(thingX)+mouseX-leftCenterW);
     println((thingX)+mouseX-leftCenterW);
    //println((leftCenterW-(thingX)+mouseX-leftCenterW)*zoomSize); //342/2=171
    
    println("");
    println((thingY)+mouseY);
    println(leftCenterH-(thingY)+mouseY-leftCenterH);
    println((leftCenterH-(thingY)+mouseY-leftCenterH)*zoomSize); //342/2=171
    println(((thingY)+mouseY-leftCenterH)*zoomSize);
    
    */
    /*
    if (thingX > leftCenterW) {
      thingX = -thingX;
    }
    */
      
    thingX = mouseX-(((leftCenterW-thingX)+(mouseX-leftCenterW))*zoomSize);
    thingY = mouseY-(((leftCenterH-thingY)+(mouseY-leftCenterH))*zoomSize); //<-- doesn't work when zoomCount = 0
    println(thingX, thingY);

    resetImgQuality();
    //image(img, (float)thingX, (float)thingY);
    confineImg();

  }
  
  if (key == 'e' && zoomCount > -1) { //zoom out
    
    zoomCount--;
    println("E:" + zoomCount);
    
    //thingX = leftCenterW-(mouseX-(((abs(thingX))+mouseX)/zoomSize));
    //thingY = leftCenterH-(mouseY-(((abs(thingY))+mouseY)/zoomSize));
    
    /*
    println(abs(thingX)+mouseX);
    println(abs(thingX)+mouseX-leftCenterW);
    println((abs(thingX)+mouseX)/zoomSize); //342/2=171
    println((abs(thingX)+mouseX-leftCenterW)/zoomSize); //342/2=171
    println(mouseX - ((abs(thingX)+mouseX)/zoomSize));
    println(leftCenterW + (mouseX - ((thingX+mouseX)/zoomSize)));
    */
    
    //thingX = mouseX-(((abs(thingX))+mouseX-leftCenterW)/zoomSize);
    //thingY = mouseY-(((abs(thingY))+mouseY-leftCenterH)/zoomSize);
    //
    
    println((thingX)+mouseX);
    println(leftCenterW-(thingX)+mouseX-leftCenterW);
    println((leftCenterW-(thingX)+mouseX-leftCenterW)/zoomSize); //342/2=171
    
    println("");
    println((thingY)+mouseY);
    println(leftCenterH-(thingY)+mouseY-leftCenterH);
    println((leftCenterH-(thingY)+mouseY-leftCenterH)/zoomSize); //342/2=171
    
    thingX = mouseX-(((leftCenterW-thingX)+(mouseX-leftCenterW))/zoomSize);
   // thingY = mouseY-((leftCenterH-(abs(thingY))+(mouseY-leftCenterH))/zoomSize);
    thingY = mouseY-(((leftCenterH-thingY)+(mouseY-leftCenterH))/zoomSize);
    
    //thingX = mouseX-(((abs(thingX))+mouseX)/zoomSize);
    //thingY = mouseY-(((abs(thingY))+mouseY)/zoomSize);
    
    //zoomCount--;
    
    println(thingX, thingY);
    //image(img, 400, 108);
    img.resize(img.width/zoomSize, img.height/zoomSize);
    //image(img, 400, 108);
    //image(img, thingX, thingY);
    
    //background(150);
    resetImgQuality();
    confineImg();
    //img.save("zoomOut.png");
    //image(img, (float)thingX, (float)thingY);
  }
    if (key == '8') {
    println (mouseX, mouseY);
  }
  
  if (key=='p')resetImgQuality();
    
}

 void resetImgQuality() {
  int imgWidth = img.width;
  int imgHeight = img.height;
  img = img2.get(0, 0, img2.width, img2.height);
  img.resize(imgWidth, imgHeight);
  
  pg = createGraphics(img.width, img.height);
  
  
  /*
  int imgWidth = img.width;
  int imgHeight = img.height;
  img = loadImage("bird.jpg");
  img.resize(imgWidth, imgHeight);
  */
  
  
}

/* confines image to the borders of imgArea */
 void confineImg() {
  //image(img, (float)thingX, (float)thingY);
  imgArea.beginDraw();
  imgArea.background(240);
  //imgArea.background(255);
  imgArea.image(img, (float)thingX-leftCenterW, (float)thingY-leftCenterH);
  //imgArea.image(img, 100, 100);
  //imgArea.image(img, 0, 0);
  //rect(thingX, thingY, img.width, img.height);
  imgArea.endDraw();
  //image(imgArea, leftCenterW, leftCenterH);
    //imgArea.save("imgArea.png");
}

   
    
