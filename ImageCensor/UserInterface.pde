PImage img, imgCopy;
PImage pixelizeIcon;
PGraphics pg; //so Restore class can edit pg created in Draw class
Selection selectionTool;
Draw drawTool;
int penSize = 5;
private Button btn1, btn2, btn3, btn9;
private CircleOnBtn btn4, btn5, btn6, btn7, btn8;
Button[] btnArray = new Button[9];
CircleOnBtn[] penSizeBtns = new CircleOnBtn[5];
Slider slide;

int leftCenterW; //x pos of left side of img so it is in the center
int leftCenterH; //y pos of left side of img so it is in the center

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
   btn3 = new Button(76, 300, 100, 60, 5, "Blur", 25, 255, "blur");
   btnArray[2] = btn3;
   
   btn9 = new Button(76, 400, 100, 30, -1, "Download", 20, 255, "download");
   btnArray[8] = btn9;
   
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
  while (img.width > width || img.height > height) {
    imgCopy.resize(img.width/2, img.height/2);
    img.resize(img.width/2, img.height/2);
  }
  
  leftCenterW = (width - img.width) / 2;
  leftCenterH = (height - img.height) / 2;
  
  image(img, leftCenterW, leftCenterH); // place image at center of screen
  
}

void draw() {
  background(13, 21, 28);
  image(pixelizeIcon, 76-pixelizeIcon.width-10, 100);
  image(img, leftCenterW, leftCenterH); // place image at center of screen again
  
  selectionTool.draw();
  for (Button btn : btnArray) {
    btn.draw();
  }
  slide.draw();
  //println(mouseX, mouseY);
}

void mousePressed() {
  selectionTool.mousePressed();
  drawTool.mousePressed();
  slide.mousePressed();
}

void mouseDragged() {
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
}

void keyPressed() {
  drawTool.keyPressed();  
  /* //Maybe try this later with alt user input setup (b/c right now image_path is null)
  if (key == 'b') {
    img = loadImage(image_path); 
  }
  */
  
  if (key == 'r') { //reset image
    Restore pixel = new Restore(imgCopy, img, 0, 0, img.width, img.height);
    pixel.restore();
    img.updatePixels();
  }
  if (key == 'e') { //reset settings
    penSize = 5;
    slide.indicatorPos = 152;
  }
    
}

   
    
