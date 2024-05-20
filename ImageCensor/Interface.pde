void setup() {
  size(1000, 500);
  //String image_path = input.getString("Enter image path");
  String image_path = "bird.jpg";
  print("image path: " + image_path);
  
  PImage image = loadImage(image_path);
  image.resize(width/4, height/2+100);
  image(image, 500-(image.width/2), 250-(image.height/2)); // place image at center of screen
  
}; 
