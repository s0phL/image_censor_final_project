PImage img, imgCopy;
PImage pixelizeIcon;
PGraphics pg; //so Restore class can edit pg created in Draw class
Selection selectionTool;
Draw drawTool;
int penSize = 5;
Button btn, btn2, btn3;
Slider slide;

static boolean onRestore = false;
static boolean onDraw = false;

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
   image(pixelizeIcon, 76-pixelizeIcon.width-10, 93);
   btn = new Button(76, 93, 100, 60, 5, "Pixelate", 25, 255, "pixelate");
   btn2 = new Button(76, 200, 100, 60, 5, "Draw", 25, 255, "draw");
   btn3 = new Button(76, 300, 100, 60, 5, "Download", 25, 255, "download");
   slide = new Slider(76, 400, 100, 10, 3, 25);
  
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
  image(pixelizeIcon, 76-pixelizeIcon.width-10, 93);
  image(img, leftCenterW, leftCenterH); // place image at center of screen again
  
  selectionTool.draw();
  btn.draw();
  btn2.draw();
  btn3.draw();
  slide.draw();
  //println(mouseX, mouseY);
}

void mousePressed() {
  selectionTool.mousePressed();
  slide.mousePressed();
}

void mouseDragged() {
  selectionTool.mouseDragged();
  drawTool.mouseDragged();
  btn.mouseDragged();
  btn2.mouseDragged();
  btn3.mouseDragged();
  slide.mouseDragged();
}

void mouseReleased() {
  selectionTool.mouseReleased();
  btn.mouseReleased();
  btn2.mouseReleased();
  btn3.mouseReleased();
}

void keyPressed() {
  //println(onDraw + " " + selectionTool.mode);
  if (onDraw) {
    drawTool.keyPressed();
  }
  else if (!onDraw && selectionTool.mode != "none") {
    selectionTool.keyPressed();
  }
 // drawTool.keyPressed();
  /*
  if (key == 'r') {
    img = loadImage(image_path);
  }
  */
  if (key == 'r') { //reset
    Restore pixel = new Restore(imgCopy, img, 0, 0, img.width, img.height);
    pixel.restore();
    img.updatePixels();
  }
}

   
    
