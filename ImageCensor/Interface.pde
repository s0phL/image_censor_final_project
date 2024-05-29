PImage img, imgCopy;
PImage pixelizeIcon;
Selection selectionTool;
Draw draw;
Button btn, btn2;
Slider slide;
private PGraphics pg, pg2;
  private int penWidth = 5;

void setup() {
  size(1000, 500);
  /*
  img = loadImage("bird.jpg");
  img.resize(img.width/2, img.height/2);
  image(img, 0, 0);
  pg = createGraphics(img.width, img.height);
  */
  insertImage("bird.jpg");

}


/*
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
  
   
   //selectionTool = new Selection("pixelate");

   //draw = new Draw(img, 5);
   

   
   
  
}
*/

void insertImage(String image_path) {
  println("image path: " + image_path);
  
  img = loadImage(image_path);
  imgCopy = loadImage(image_path); //img to reference when restoring edited img
  while (img.width > width || img.height > height) {
    imgCopy.resize(img.width/2, img.height/2);
    img.resize(img.width/2, img.height/2);
  }
  
  image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen
  
  pg = createGraphics(width, height);
  pg2 = createGraphics(width, height);
  
}

void draw() {
  //background(13, 21, 28);
  //image(img, 500-(img.width/2), 250-(img.height/2)); // place image at center of screen again

  //println(mouseX, mouseY);
  //image(imgCopy, 10, 10);
}

void mousePressed() {

}

void mouseDragged() {
  strokeWeight(5);
  line(pmouseX, pmouseY, mouseX, mouseY);
  pg.beginDraw();
  pg.strokeWeight(5);
  pg.line(pmouseX, pmouseY, mouseX, mouseY);

  //pg.image(pg, mouseX - pg.width / 2, mouseY - pg.height / 2);
  pg.endDraw();
}

void mouseReleased() {
  pg.save("test.png");
  //image(pg, 50, 50);
  //img = pg.get((500-(img.width/2)), (500-(img.width/2)), img.width, img.height);
  imgCopy = pg.get();
  //imgCopy = pg.get((500-(img.width/2)), (500-(img.width/2)), img.width, img.height);
  imgCopy.resize(img.width, img.height);
  imgCopy.save("testt.png");
  println(imgCopy.width, imgCopy.height);
  //print(drawLayer.width);
  //image(imgCopy, 500, 50);
  print(pg.width);
  //img.copy(pg, 0, 0, pg.width, pg.height, (500-(img.width/2)), (500-(img.width/2)), img.width, img.height);
  
  pg2.beginDraw();
  pg2.image(img, 500-(img.width/2), 250-(img.height/2));
  pg2.image(pg, 0, 0);
  pg2.endDraw();
  
  img = pg2.get((500-(img.width/2)), 50, img.width, img.height);
  
  pg2.save("ahdsah.png");
  
  
  
  pushMatrix();
  translate(120, 80);
  //image(img, 0, 0);
  popMatrix();
  img.save("etsy.png");
  

  
  
  }
private boolean onImage() {
    //mouseIndexRelativeToImg
    return (((mouseX-(500-(img.width/2))) > 0) && ((mouseX-(500-(img.width/2))) < img.width) && ((mouseY-(250-(img.width/2))) > 0) && ((mouseY-(250-(img.width/2))) < img.height));
  }
   
   
    
