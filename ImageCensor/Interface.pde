PImage img;
int a, b, c, d;
//Pixelate pixel;

void setup() {
  size(1000, 500);
  
    a=0;
    b=0;
    c=0;
    d=0;
  
  try {
    String image_path = input.getString("Enter image path");
    insertImage(image_path);
  } catch (NullPointerException e) { //defaults to bird.jpg if user input
    String image_path = "bird.jpg";
    //image_path = input.getString("Invalid path. Please try again");
    insertImage(image_path);
  }
  
  /*
   Pixelate pixel = new Pixelate(img, 0, 0);
  
  
   println(img.width); //342
   println(img.height); //400
   println(img.pixels.length); //136800
   println(img.height % 3); //1
   
   pixel.pixelate(3);
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



void draw() {
  //background(255);
  background(0);
  image(img, 500-(img.width/2), 250-(img.height/2));
  stroke(255);
  strokeWeight(2);
  noFill();
  if (mousePressed) {
    rect(a, b, c, d);
  }

  println(mouseX + "::" + mouseY + "||" + (500-(img.width/2)) + ":" + (250-(img.height/2)) + "||" + a + ":" + b);
}


void mousePressed() {
  a=mouseX;
  b=mouseY;
}


void mouseDragged() {
  c=mouseX-a;
  d=mouseY-b;
  //rect(a, b, c, d);
}

void mouseReleased() {
  background(0);
  println(a + ":" + b + ":" + c + ":" + d);
  
  Pixelate pixel = new Pixelate(img, abs(a-(500-(img.width/2))), abs(b-(250-(img.height/2))), c, d);
  
  pixel.pixelate(3);
  img.updatePixels();
  image(img, 500-(img.width/2), 250-(img.height/2));
  
  a=0;
  b=0;
  c=0;
  d=0;
  
}
    
