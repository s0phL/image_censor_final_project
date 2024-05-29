PImage img, imgCopy;
PImage pixelizeIcon;
Selection selectionTool;
Button btn, btn2;
Slider slide;
float op = 3;

PGraphics pg;


void setup() {
  size(1000, 500, P3D);
  
  try {
    //String image_path = input.getString("Enter image path");
    //insertImage(image_path);
    insertImage("bird.jpg");
  } 
  catch (NullPointerException e) { //defaults to bird.jpg if user input
    String image_path = "bird.jpg";
    //image_path = input.getString("Invalid path. Please try again");
    insertImage(image_path);
  }
  
  /*
   Pixelate2 pixel2 = new Pixelate2(img, 0, 0, 342, 400);
  
  
   println(img.width); //342
   println(img.height); //400
   println(img.pixels.length); //136800
   println(img.height % 3); //1
   
   pixel2.pixelate(3);
   img.updatePixels();
   image(img, 500-(img.width/2), 250-(img.height/2));
   */
   
   //selectionTool = new Selection("pixelate");
   selectionTool = new Selection("none");
   
   pixelizeIcon = loadImage("images/pixelize.png");
   pixelizeIcon.resize(50, 50);
   image(pixelizeIcon, 76-pixelizeIcon.width-10, 93);
   btn = new Button(76, 93, 100, 60, 5, "Pixelate", 25, 255, "pixelate");
   btn2 = new Button(76, 200, 100, 60, 5, "Download", 25, 255, "download");
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
  
  image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen
  
  pg = createGraphics(img.width, img.height);
  
}

void draw() {
  background(13, 21, 28);
  image(pixelizeIcon, 76-pixelizeIcon.width-10, 93);
  image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen again
  
  selectionTool.draw();
  btn.draw();
  btn2.draw();
  slide.draw();
  //println(mouseX, mouseY);
  
 
  if (keyPressed && key == 'a') {
    
     op += 0.05; 
     float fov = PI/op+0.01;
     //float cameraZ = (height/2.0) / tan(fov/2.0);    
     float cameraZ = (height/2.0) / tan(fov/2.0);    
    
    pg.beginDraw();
     perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
     pg.endDraw();
     //perspective(fov, img.width/img.height, cameraZ/10.0, cameraZ*10.0);
  }
  
  if (keyPressed && key == 'b' && op > 3) {
    
     op -= 0.05; 
     
     float fov = PI/op+0.01;
     //float cameraZ = (height/2.0) / tan(fov/2.0);    
     float cameraZ = (height/2.0) / tan(fov/2.0);    
    
     perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
     //perspective(fov, img.width/img.height, cameraZ/10.0, cameraZ*10.0);
  }
}

void mousePressed() {
  selectionTool.mousePressed();
  slide.mousePressed();
}

void mouseDragged() {
  selectionTool.mouseDragged();
  btn.mouseDragged();
  btn2.mouseDragged();
  slide.mouseDragged();
}

void mouseReleased() {
  selectionTool.mouseReleased();
  btn.mouseReleased();
  btn2.mouseReleased();
}

   
    
