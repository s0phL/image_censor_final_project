PImage img, imgCopy, oldImg, exOldImg; //imgCopy==reference for restore, oldImg+exOldImg==for undo/redo
PImage img2;
// NEED BETTER NAMES!!!!!
PImage pixelizeIcon, drawIcon, blurIcon, downloadIcon, fullCensorIcon;
PGraphics pg; //so Restore class can edit pg created in Draw class
PGraphics imgArea; 
Selection selectionTool;
Draw drawTool;
int penSize = 5;
private Button btn1, btn2, btn3, btn9, btn10;
private CircleOnBtn btn4, btn5, btn6, btn7, btn8;
Button[] btnArray = new Button[10];
CircleOnBtn[] penSizeBtns = new CircleOnBtn[5];
Slider slide;

int leftCenterW; //x pos of left side of img so it is in the center
int leftCenterH; //y pos of left side of img so it is in the center

private boolean usedUndo = false;

int zoomSize = 2;
int zoomCount = 0;
double thingX; // image centered at mouse x  // NEED BETTER NAME
double thingY; 

int xStart;
int yStart;

void setup() {
  size(1000, 500);
  
  //getImage("Enter image path (starting from home dir)");
  insertImage("bird.jpg");
  
  /*
   println(img.width); //342   329 start 671 end
   println(img.height); //400
   println(img.pixels.length); //136800
   println(img.height % 3); //1 
  */
   
   selectionTool = new Selection("none");
   drawTool = new Draw();
   
   pixelizeIcon = loadImage("assets/pixelize.png");
   pixelizeIcon.resize(50, 50);
   
   drawIcon = loadImage("assets/pencil.png");
   drawIcon.resize(50, 50);
   
   blurIcon = loadImage("assets/blur.png");
   blurIcon.resize(50, 50);
   
   fullCensorIcon = loadImage("assets/blackSquare.png");
   fullCensorIcon.resize(50, 50);
   
   btn1 = new Button(86, 80, 100, 60, 5, "Pixelate", 25, 255, "pixelate");
   btnArray[0] = btn1;
   btn2 = new Button(86, 180, 100, 60, 5, "Draw", 25, 255, "draw");
   btnArray[1] = btn2;
   btn3 = new Button(86, 280, 100, 60, 5, "Blur", 25, 255, "blur");
   btnArray[2] = btn3;
   btn9 = new Button(86, 380, 100, 60, 12, "Censor \nEverything", 20, 255, "fullCensor");
   btnArray[8] = btn9;
   
   btn10 = new Button(765, 410, 100, 30, -1, "Download", 20, 255, "download");
   btnArray[9] = btn10;
   
   /* appears on draw. changes pen size */
   btn4 = new CircleOnBtn(235, 150, 30, 30, 5, "", 25, 255, "penChange", 25);
   btnArray[3] = btn4;
   penSizeBtns[0] = btn4;
   btn5 = new CircleOnBtn(235, 190, 30, 30, 5, "", 25, 255, "penChange", 20);
   btnArray[4] = btn5;
   penSizeBtns[1] = btn5;
   btn6 = new CircleOnBtn(235, 230, 30, 30, 5, "", 25, 255, "penChange", 15);
   btnArray[5] = btn6;
   penSizeBtns[2] = btn6;
   btn7 = new CircleOnBtn(235, 270, 30, 30, 5, "", 25, 255, "penChange", 10);
   btnArray[6] = btn7;
   penSizeBtns[3] = btn7;
   btn8 = new CircleOnBtn(235, 310, 30, 30, 5, "", 25, 255, "penChange", 5);
   btnArray[7] = btn8;
   penSizeBtns[4] = btn8;
   
   /* appears on pixelate. adjusts pixelization amount */
   slide = new Slider(235, 150, 10, 200, 3, 25);
  
}

boolean onImage() {
  return (((mouseX - leftCenterW) > 0) && ((mouseX - leftCenterW) < img.width) && ((mouseY - leftCenterH) > 0) && ((mouseY - leftCenterH) < img.height));
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
  imgArea.beginDraw();
  imgArea.background(240);
  imgArea.image(img, (float)thingX-leftCenterW, (float)thingY-leftCenterH);
  imgArea.endDraw();
}

void draw() {
  background(13, 21, 28);
  //background(19, 31, 41);
  image(pixelizeIcon, 86-pixelizeIcon.width-10, 80);
  image(drawIcon, 86-drawIcon.width-10, 180);
  image(blurIcon, 86-blurIcon.width-10, 280);
  image(fullCensorIcon, 86-fullCensorIcon.width-10, 380);
  //image(img, leftCenterW, leftCenterH); // place image at center of screen again
  image(imgArea, leftCenterW, leftCenterH); // place image at center of screen again
  //confineImg();
  
  selectionTool.draw();
  for (Button btn : btnArray) {
    btn.draw();
  }
  slide.draw();
}

void mousePressed() {
  if (onImage()) {
    oldImg = img.get(0, 0, img.width, img.height); //save img before action in case want to undo
    usedUndo = false;
  }
  
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
  
  if(key=='1')println(mouseX, mouseY);
  
  if (key=='7') {
    pg.save("pg.png");
    img2.save("img2.png");
  }
  
  if (key == 'r') { //reset image
    zoomCount = 0;
    xStart = 0;
    yStart = 0;
    thingX = leftCenterW;
    thingY = leftCenterH;
    img = imgCopy.get(0, 0, imgCopy.width, imgCopy.height);
    img2 = imgCopy.get(0, 0, imgCopy.width, imgCopy.height);
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
  
  if (key == '9' && !usedUndo) { //undo most recent action
    exOldImg = oldImg.get(0, 0, img.width, img.height);
    oldImg = img.get(0, 0, img.width, img.height); //for redo
    img = exOldImg.get(0, 0, img.width, img.height);
    pg = createGraphics(img.width, img.height); //erase drawing
    usedUndo = true;
  }
  if ((key == '0') && usedUndo) { //redo
    exOldImg = oldImg.get(0, 0, img.width, img.height);
    oldImg = img.get(0, 0, img.width, img.height); //for undo
    img = exOldImg.get(0, 0, img.width, img.height);
    usedUndo = false;
  }
  
  if (key == 'q' && zoomCount < 3) { //zoom in
    img.resize(img.width*zoomSize, img.height*zoomSize);
    zoomCount++;
    println("Q:" + zoomCount);
      
    thingX = mouseX-(((leftCenterW-thingX)+(mouseX-leftCenterW))*zoomSize);
    thingY = mouseY-(((leftCenterH-thingY)+(mouseY-leftCenterH))*zoomSize);
    println(thingX, thingY);

    resetImgQuality();
    //image(img, (float)thingX, (float)thingY);
    confineImg();

  }
  
  if (key == 'e' && zoomCount > -1) { //zoom out
    img.resize(img.width/zoomSize, img.height/zoomSize);
    zoomCount--;
    println("E:" + zoomCount);
    
    thingX = mouseX-(((leftCenterW-thingX)+(mouseX-leftCenterW))/zoomSize);
    thingY = mouseY-(((leftCenterH-thingY)+(mouseY-leftCenterH))/zoomSize);
    println(thingX, thingY);

    resetImgQuality();
    confineImg();
  }
    
}

/* asks user for image path of the image they want to edit. 
 * once gets path, calls insertImage method
 * if path does not exist, asks user again for a valid path.
*/
private void getImage(String inputPrompt){
  String image_path;
  try {
    image_path = System.getProperty("user.home") + "/" + input.getString(inputPrompt);
    
    println("image path: " + image_path);
  
    insertImage(image_path);
  } 
  catch (NullPointerException e) { 
    getImage("Invalid path. Please try again");
  }
}

/* inserts image into the processing screen 
 * makes image smaller if it exceeds processing screen dimentions
*/
private void insertImage(String image_path) {
  img = loadImage(image_path);
  
  while (img.width > width || img.height > height) {
    //imgCopy.resize(img.width/2, img.height/2);
    img.resize(img.width/2, img.height/2);
  }
  
  img2 = img.get(0, 0, img.width, img.height);
  imgCopy = img.get(0, 0, img.width, img.height);
  
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
  
  //image(img, leftCenterW, leftCenterH); // place image at center of screen
}



   
    
