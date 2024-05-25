PImage img, imgCopy;
Selection selectionTool;
Button btn;

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
   Pixelate2 pixel2 = new Pixelate2(img, 0, 0, 342, 400);
  
  
   println(img.width); //342
   println(img.height); //400
   println(img.pixels.length); //136800
   println(img.height % 3); //1
   
   pixel2.pixelate(3);
   img.updatePixels();
   image(img, 500-(img.width/2), 250-(img.height/2));
   */
   
   selectionTool = new Selection();
   btn = new Button(76, 93, 100, 60, 5, "Pixelate", 25, 255);
  
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
  
}

void draw() {
  selectionTool.draw();
  btn.draw();
  //println(mouseX, mouseY);
}

void mousePressed() {
  selectionTool.mousePressed();
}

void mouseDragged() {
  selectionTool.mouseDragged();
  btn.mouseDragged();
}

void mouseReleased() {
  selectionTool.mouseReleased();
  btn.mouseReleased();
  
}
   
   
    
