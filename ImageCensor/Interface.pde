String image_path;
PImage img;

void setup() {
  size(1000, 500);
  try {
    image_path = input.getString("Enter image path");
    insertImage();
  } catch (NullPointerException e) { //defaults to bird.jpg if user input
    image_path = "bird.jpg";
    //image_path = input.getString("Invalid path. Please try again");
    insertImage();
  }
  println("image path: " + image_path);
  
  image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen
  
   Pixelate pixel = new Pixelate(img);
  
   println(img.width); //342
   println(img.height); //400
   println(img.pixels.length); //136800
   println(img.height % 3); //1
   pixel.pixelate(3);
   img.updatePixels();
   image(img, 500-(img.width/2), 250-(img.height/2));
  
}; 

void insertImage() {
  img = loadImage(image_path);
  while (img.width > width || img.height > height) {
    img.resize(img.width/2, img.height/2);
  }
}
    
