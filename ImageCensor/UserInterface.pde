PImage img, img2, imgCopy; //img2==reference when resizing to keep quality, imgCopy==reference for restore
PImage oldImg, exOldImg, oldImg2, exOldImg2; //for undo/redo
PImage pixelizeIcon, drawIcon, blurIcon, downloadIcon, censorBarIcon, fullCensorIcon;
PGraphics pg;
PGraphics imgArea; 
Selection selectionTool;
Draw drawTool;
int penSize = 5;
Stamp censorStamp;
private Button btn1, btn2, btn3, btn9, btn10, btn11;
private CircleOnBtn btn4, btn5, btn6, btn7, btn8;
Button[] btnArray = new Button[11];
CircleOnBtn[] penSizeBtns = new CircleOnBtn[5];
Slider slide;

int leftCenterW; //x pos of left side of img so it is in the center
int leftCenterH; //y pos of left side of img so it is in the center

int zoomSize = 2;
int zoomCount = 0;
double upLeftX; //x-coord of upper left corner of resized image
double upLeftY; //y-coord of upper left corner of resized image

private int xStart;
private int yStart;

private boolean usedUndo = false;
private double oldUpLeftX, exOldUpLeftX;
private double oldUpLeftY, exOldUpLeftY;

void setup() {
  size(1000, 500);
  
  //getImage("Enter image path (starting from home dir)");
  insertImage("bird.jpg");
   
   selectionTool = new Selection("none");
   drawTool = new Draw();
   censorStamp = new Stamp();
   
   pixelizeIcon = loadImage("assets/pixelize.png");
   pixelizeIcon.resize(50, 50);
   
   drawIcon = loadImage("assets/pencil.png");
   drawIcon.resize(50, 50);
   
   blurIcon = loadImage("assets/blur.png");
   blurIcon.resize(50, 50);
   
   censorBarIcon = loadImage("assets/censorBar.png");
   censorBarIcon.resize(25, 25);
   
   fullCensorIcon = loadImage("assets/blackSquare.png");
   fullCensorIcon.resize(25, 25);
   
   btn1 = new Button(96, 70, 100, 60, 0, "Pixelate", 25, 255, "pixelate");
   btnArray[0] = btn1;
   btn2 = new Button(96, 165, 100, 60, 0, "Draw", 25, 255, "draw");
   btnArray[1] = btn2;
   btn3 = new Button(96, 260, 100, 60, 0, "Blur", 25, 255, "blur");
   btnArray[2] = btn3;
   btn10 = new Button(86, 355, 120, 35, -1, "Censor Bar", 15, 255, "stamp");
   btnArray[9] = btn10;
   btn9 = new Button(86, 410, 120, 35, -1, "Censor Everything", 15, 255, "fullCensor");
   btnArray[8] = btn9;
   
   btn11 = new Button(765, 410, 100, 30, -1, "Download", 15, 255, "download");
   btnArray[10] = btn11;
   
   /* appears on draw. changes pen size */
   btn4 = new CircleOnBtn(240, 150, 30, 30, 5, "", 25, 255, "penChange", 25);
   btnArray[3] = btn4;
   penSizeBtns[0] = btn4;
   btn5 = new CircleOnBtn(240, 190, 30, 30, 5, "", 25, 255, "penChange", 20);
   btnArray[4] = btn5;
   penSizeBtns[1] = btn5;
   btn6 = new CircleOnBtn(240, 230, 30, 30, 5, "", 25, 255, "penChange", 15);
   btnArray[5] = btn6;
   penSizeBtns[2] = btn6;
   btn7 = new CircleOnBtn(240, 270, 30, 30, 5, "", 25, 255, "penChange", 10);
   btnArray[6] = btn7;
   penSizeBtns[3] = btn7;
   btn8 = new CircleOnBtn(240, 310, 30, 30, 5, "", 25, 255, "penChange", 5);
   btnArray[7] = btn8;
   penSizeBtns[4] = btn8;
   
   /* appears on pixelate. adjusts pixelization amount */
   slide = new Slider(250, 150, 10, 200, 3, 25);
  
}

boolean onImage() {
  boolean withinImgArea = ((mouseX - leftCenterW) > 0) && ((mouseX - leftCenterW) < img.width) && ((mouseY - leftCenterH) > 0) && ((mouseY - leftCenterH) < img.height);
  boolean withinImg = (mouseX > upLeftX) && (mouseX < (upLeftX + img.width)) && (mouseY > upLeftY) && (mouseY < (upLeftY + img.height));
  return withinImgArea && withinImg;
}

/* save img and other coordinate states before action in case want to undo */
void saveImageState() {
  oldImg = img.get(0, 0, img.width, img.height);
  oldImg2 = img2.get(0, 0, img.width, img.height);
  oldUpLeftX = upLeftX;
  oldUpLeftY = upLeftY;
  usedUndo = false;
}

/* references img2 to get edited image to reset quality and then resizes it to match current zoom state */
void resetImageQuality() {
  int imgWidth = img.width;
  int imgHeight = img.height;
  img = img2.get(0, 0, img2.width, img2.height);
  img.resize(imgWidth, imgHeight);

  pg = createGraphics(img.width, img.height);
}

/* confines image to the borders of imgArea */
void confineImg() {
  if (mouseButton != RIGHT) {
    imgArea.beginDraw();
    imgArea.background(240);
    imgArea.image(img, (float)(upLeftX - leftCenterW), (float)(upLeftY - leftCenterH));
    imgArea.endDraw();
  }
}

void draw() {
  background(13, 21, 28);
  //background(19, 31, 41);
  image(pixelizeIcon, 96-pixelizeIcon.width-10, 70);
  image(drawIcon, 96-drawIcon.width-10, 165);
  image(blurIcon, 96-blurIcon.width-10, 260);
  image(censorBarIcon, 86-censorBarIcon.width-10, 355);
  image(fullCensorIcon, 86-fullCensorIcon.width-10, 410);
  image(imgArea, leftCenterW, leftCenterH); // place image at center of screen again
  
  selectionTool.draw();
  for (Button btn : btnArray) {
    btn.draw();
  }
  slide.draw();
}

void mousePressed() {
  if (onImage()) {
    saveImageState(); //save image before next action
  }
  
  if (mouseButton == RIGHT) { //for image drag
    xStart = mouseX;
    yStart = mouseY;
  }
  else {
    selectionTool.mousePressed();
    drawTool.mousePressed();
    slide.mousePressed();
    censorStamp.mousePressed();
  }
}

void mouseDragged() {
  if (mouseButton == RIGHT) { //for image drag
    resetImageQuality();
    imgArea.beginDraw();
    imgArea.background(240);
    imgArea.image(img, (float)upLeftX-leftCenterW+(mouseX-xStart), (float)upLeftY-leftCenterH+(mouseY-yStart));
    imgArea.endDraw();
    //delay(1);
  }
  else { 
    selectionTool.mouseDragged();
    drawTool.mouseDragged();
    for (Button btn : btnArray) {
      btn.mouseDragged();
    }
    slide.mouseDragged();
  }
}

void mouseReleased() {  
  if (mouseButton == RIGHT) { //for image drag
    upLeftX += (mouseX-xStart);
    upLeftY += (mouseY-yStart);
  }
  else {
    selectionTool.mouseReleased();
    for (Button btn : btnArray) {
      btn.mouseReleased();
    }
  }
}

void keyPressed() {
  drawTool.keyPressed();  
  println(key);
  
  if(key=='7'){
    pg.save("pg.png");
    img.save("img.png");
    img2.save("img2.png");
  }
  if(key=='6') {
        imgArea.beginDraw();
    imgArea.background(240);
    imgArea.fill(0);
    imgArea.rect(0, 0, img2.width, img2.height);
    imgArea.image(img, (float)(upLeftX - leftCenterW), (float)(upLeftY - leftCenterH));
    imgArea.endDraw();
  }
  
  /* reset image */
  if (key == 'r') { 
    zoomCount = 0;
    xStart = 0;
    yStart = 0;
    upLeftX = leftCenterW;
    upLeftY = leftCenterH;
    img = imgCopy.get(0, 0, imgCopy.width, imgCopy.height);
    img2 = imgCopy.get(0, 0, imgCopy.width, imgCopy.height);
    confineImg();
  }
  /* reset settings */
  if (key == '4') { 
    penSize = 5;
    slide.indicatorPos = 152;
    zoomCount = 0;
    xStart = 0;
    yStart = 0;
    upLeftX = leftCenterW;
    upLeftY = leftCenterH;
    img = img2.get(0, 0, img2.width, img2.height);
    confineImg();
  }
  
  /* undo most recent action.
   * sets img to previous saved state that was saved before action was done
  */
  if (key == '9' && !usedUndo) {
    exOldImg = oldImg.get(0, 0, img.width, img.height);
    oldImg = img.get(0, 0, img.width, img.height); //for redo
    img = exOldImg.get(0, 0, img.width, img.height);
    
    exOldImg2 = oldImg2.get(0, 0, img.width, img.height);
    oldImg2 = img2.get(0, 0, img.width, img.height); 
    img2 = exOldImg2.get(0, 0, img.width, img.height);
    
    exOldUpLeftX = oldUpLeftX;
    oldUpLeftX = upLeftX;
    upLeftX = exOldUpLeftX;
    exOldUpLeftY = oldUpLeftY;
    oldUpLeftY = upLeftY;
    upLeftY = exOldUpLeftY;
    
    confineImg();
    pg = createGraphics(img.width, img.height); //erase drawing
    usedUndo = true;
  }
  /* redo the undo */
  if ((key == '0') && usedUndo) { 
    exOldImg = oldImg.get(0, 0, img.width, img.height);
    oldImg = img.get(0, 0, img.width, img.height); //for undo
    img = exOldImg.get(0, 0, img.width, img.height);
    
    exOldImg2 = oldImg2.get(0, 0, img.width, img.height);
    oldImg2 = img2.get(0, 0, img.width, img.height); 
    img2 = exOldImg2.get(0, 0, img.width, img.height);
    
    exOldUpLeftX = oldUpLeftX;
    oldUpLeftX = upLeftX;
    upLeftX = exOldUpLeftX;
    exOldUpLeftY = oldUpLeftY;
    oldUpLeftY = upLeftY;
    upLeftY = exOldUpLeftY;
    
    confineImg();
    pg = createGraphics(img.width, img.height); //erase drawing
    usedUndo = false;
  }
  
  /* zoom in.
   * resizes image by multiplying zoom size. 
   * then translates the upper left corner left so the image is focused on mouse pos
  */
  if (key == 'q' && zoomCount < 3) {
    saveImageState();
    img.resize((img.width * zoomSize), (img.height * zoomSize));
    zoomCount++;
    println("Q:" + zoomCount);
      
    upLeftX = mouseX - (((leftCenterW - upLeftX) + (mouseX - leftCenterW)) * zoomSize);
    upLeftY = mouseY - (((leftCenterH - upLeftY) + (mouseY - leftCenterH)) * zoomSize);
    //println(upLeftX, upLeftY);

    resetImageQuality();
    confineImg();
  }
  /* zoom out.
   * resizes image by dividing by zoom size. 
   * then translates the upper left corner right so the image is focused on mouse pos
  */
  if (key == 'e' && zoomCount > -1) {
    saveImageState();
    img.resize((img.width / zoomSize), (img.height / zoomSize));
    zoomCount--;
    println("E:" + zoomCount);
    
    upLeftX = mouseX-(((leftCenterW-upLeftX)+(mouseX-leftCenterW))/zoomSize);
    upLeftY = mouseY-(((leftCenterH-upLeftY)+(mouseY-leftCenterH))/zoomSize);
    println(upLeftX, upLeftY);

    resetImageQuality();
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
    img.resize((img.width / 2), (img.height / 2));
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
  
  upLeftX = leftCenterW;
  upLeftY = leftCenterH;

  pg = createGraphics(img.width, img.height);
}



   
    
