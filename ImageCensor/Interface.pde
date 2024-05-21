void setup() {
  size(1000, 500);
  String image_path;
  PImage image;
  try {
    image_path = Input.getString("Enter image path");
    image = loadImage(image_path);
    image.resize(width/4, height/2+100);
  } catch (NullPointerException e) { //defaults to bird.jpg if user input
    image_path = "bird.jpg";
    image = loadImage(image_path);
    image.resize(width/4, height/2+100);
  }
  print("image path: " + image_path);
  
  image(image, 500-(image.width/2), 250-(image.height/2)); // place image at center of screen
  
}; 
