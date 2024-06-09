PGraphics pg, pg2;
PImage img, imgCopy, img3;
int zoomSize = 2;
//int zoomSize = 3;
int zoomCount = 0;
int thingX; // image centered at mouse x
int thingY; 

int xStart;
int yStart;

void setup() {
  size(342, 400);
  //size(1000, 500);
  img = loadImage("bird.jpg");
  img.resize(342, 400);
  imgCopy = loadImage("bird.jpg");
  imgCopy.resize(342, 400);
  rect(0, 0, 342, 400);
  image(img, 0, 0);
  rect(144, 114, 2, 2);
  //pg = createGraphics(img.width*2, img.height*2);
  pg = createGraphics(img.width, img.height);
  //pg2 = createGraphics(img.width, img.height);
  
  println(img.width, img.height);
}

void draw() {
  //println(mouseX, mouseY);
}

void keyPressed() {
  //OutOfMemoryError @ img.height == 12800
  if (key == 'a' && zoomCount < 3) {
    img.resize(img.width*zoomSize, img.height*zoomSize);
    //image(img, mouseX-img.width, mouseY-img.height);
    //image(img, 0, 0);
    //image(img, 0-(mouseX*(zoomSize-1)), 0-(mouseY*(zoomSize-1)));
    zoomCount++;
    println("A:" + zoomCount);
    thingX = 0-(mouseX*((int)(Math.pow(zoomSize, zoomCount)))-mouseX);
    thingY = 0-(mouseY*((int)(Math.pow(zoomSize, zoomCount)))-mouseY);
    
    //thingX = 0+(mouseX-(((abs(thingX))+mouseX)*zoomSize));
    //thingY = 0+(mouseY-(((abs(thingY))+mouseY)*zoomSize)); <-- doesn't work when zoomCount = 0
    println(thingX, thingY);
    background(150);
    
    
    int imgWidth = img.width;
    int imgHeight = img.height;
    img = loadImage("bird.jpg");
    img.resize(imgWidth, imgHeight);
    
    image(img, (float)thingX, (float)thingY);
    println(img.height);
    
  }
  
  if (key == 'b' && zoomCount > -1) {
  //if (key == 'b') {

    //thingX = mouseX-mouseX/3;
    //thingY = mouseY-mouseY/3;
    
    //zoomCount--;
    //zoomCount++;
    println("B:" + zoomCount);
    //thingX = 0+(mouseX-((thingXMAX+mouseX)/((int)(Math.pow(zoomSize, zoomCount)))));
    //thingY = 0+(mouseY-((thingYMAX+mouseY)/((int)(Math.pow(zoomSize, zoomCount)))));
    
    //thingX = 0+(mouseX-((thingXMAX+mouseX)/zoomSize));
    //thingY = 0+(mouseY-((thingYMAX+mouseY)/zoomSize));
    
    thingX = 0+(mouseX-(((abs(thingX))+mouseX)/zoomSize));
    thingY = 0+(mouseY-(((abs(thingY))+mouseY)/zoomSize));
    zoomCount--;
    
    println(thingX, thingY);
    img.resize(img.width/zoomSize, img.height/zoomSize);
    background(150);
    
        int imgWidth = img.width;
    int imgHeight = img.height;
    img = loadImage("bird.jpg");
    img.resize(imgWidth, imgHeight);
    
    
    image(img, (float)thingX, (float)thingY);
    //image(img, 0, 0);
    rect(144/3, 114/3, 2, 2);
    

  }
  
  if (key == 'r') {
    //background(100);
    img.resize(342, 400);
    image(img, 0, 0);
  }
  
  if (key == 't') {
    img = loadImage("bird.jpg");
      img.resize(342, 400);

    image(img, 0, 0);
  }
  
  if (key == 'e') {
    println(mouseX, mouseY);
  }
  

}

void mousePressed() {
  if (mouseButton == RIGHT) {
    xStart = mouseX;
    yStart = mouseY;
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    line(pmouseX, pmouseY, mouseX, mouseY);
    pg.beginDraw();
        pg.pushMatrix();

    //pg.translate(-342/2, -400/2);
    //pg.translate(0, -200);
    pg.scale(2);
    //pg.scale(0.5);
    pg.line(pmouseX, pmouseY, mouseX, mouseY);
    pg.popMatrix();
    pg.endDraw();
    pg.save("test.png");
  }
  if (mouseButton == RIGHT) {
    background(150);
    image(img, thingX+(mouseX-xStart), thingY+(mouseY-yStart));
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    thingX += (mouseX-xStart);
    thingY += (mouseY-yStart);
  }
  
  //imgCopy.resize(img.width, img.height);
  
  //img3 = pg.get(0, 0, img.width, img.height);
  //img3.resize(img.width/zoomSize, img.height/zoomSize);
  
  //img3.save("t.png");
  
  else {
  pg2 = createGraphics(img.width, img.height);
  
  pg2.beginDraw();
  //pg2.image(imgCopy, thingX, thingY);
  pg2.image(img, 0, 0);
  //pg2.image(img3, 0, 0);
  pg2.image(pg, 0, 0);
  pg2.endDraw();
  
  pg2.save("pg2.png");
  
  img = pg2.get(thingX, thingY, img.width, img.height);
  
  imgCopy = loadImage("bird.jpg");
  imgCopy.resize(342, 400);
  }
  
}
