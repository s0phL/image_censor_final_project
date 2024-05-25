// THIS IS AN ALT VERSION FOR USER_INPUT
// instead of defaulting to bird.jpg, asks user to input a valid path

PImage img;

void setup() {
  size(1000, 500);
  
  getImage("Enter image path");
  
  Pixelate pixel = new Pixelate(img);
  pixel.pixelate(3);
  img.updatePixels();
  image(img, 500-(img.width/2), 250-(img.height/2));
  
}

/* asks user for image path of the image they want to edit. 
 * image will then be inserted into the processing screen
 * if path does not exist, asks user again for a valid path.
*/
void getImage(String inputPrompt){
  String image_path;
  try {
    //image_path = "../../../../" + input.getString(inputPrompt);
    image_path = input.getString(inputPrompt);
    
    println("image path: " + image_path);
  
    img = loadImage(image_path);
    while (img.width > width || img.height > height) {
      img.resize(img.width/2, img.height/2);
    }
      
    image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen
     
  } catch (NullPointerException e) { 
    getImage("Invalid path. Please try again");
  }
}
    
