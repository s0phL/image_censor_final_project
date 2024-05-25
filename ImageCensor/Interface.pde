PImage img;
int xStart, yStart, rectWidth, rectHeight = 0; //for selection tool. initialize to 0 so doesn't appear

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
  
}

void insertImage(String image_path) {
  println("image path: " + image_path);
  
  img = loadImage(image_path);
  while (img.width > width || img.height > height) {
    img.resize(img.width/2, img.height/2);
  }
  
  image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen
}



/* SELECTION TOOL */

void draw() {
  background(0);
  image(img, 500-(img.width/2), 250-(img.height/2));
  stroke(255);
  strokeWeight(2);
  noFill();
  if (mousePressed) {
    rect(xStart, yStart, rectWidth, rectHeight);
  }

  //println(mouseX + "::" + mouseY + "||" + (500-(img.width/2)) + ":" + (250-(img.height/2)) + "||" + a + ":" + b);
}

void mousePressed() {
  xStart = mouseX;
  yStart = mouseY;
}

void mouseDragged() {
  rectWidth = mouseX - xStart;
  rectHeight = mouseY - yStart;
}

/* pixelize image based off what's inside the rectangle selection */
void mouseReleased() {
  //background(0);
  
  println("");
  println("=========");
  
  Pixelate pixel;
  if (rectWidth > 0) { //if user selects from top-left to bottom-right, start point is start pixel
    pixel = new Pixelate(img, (xStart-(500-(img.width/2))), (yStart-(250-(img.height/2))), rectWidth, rectHeight);
  }
  else { //if user selects from bottom-right to top-left, end point is start pixel
    pixel = new Pixelate(img, (mouseX-(500-(img.width/2))), (mouseY-(250-(img.height/2))), abs(rectWidth), abs(rectHeight));
  }
  
  pixel.pixelate(8);
  
  img.updatePixels();
  
  /* make selection rectangle disappear after mouse release */
  xStart = 0;
  yStart = 0;
  rectWidth = 0;
  rectHeight = 0;
  
}
    
