int sWidth = 600; // canvas width
int sHeight = 600; // canvas height
PImage input; // input image
PImage output; // output image
int oHeight; // output image height
int oWidth; // output image widht
int centerX; // canvas center x-axis
int centerY; // canvas center y-axis
int counter = 0;
String fileName; // image file name

void setup() {
  //size(sWidth, sHeight);
  size(displayWidth, displayHeight);
  selectInput("Select an image file (.png, .jpg, .gif) to process:", "selectFile");
}

/*
 * Generate a new image making the pixels of the selected one to flow.
 */

void draw() {
  background(255);
  if(input != null) {
    oHeight = floor(input.pixels.length / oWidth); // output height
    output = createImage(oWidth, oHeight, RGB); // output image
    input.loadPixels();
    output.loadPixels();
  
    for (int x = 0; x < oWidth; x++) {
      for (int y = 0; y < oHeight; y++ ) {
        int loc = x + y*oWidth;
        float r = red(input.pixels[loc]);
        float g = green(input.pixels[loc]);
        float b = blue(input.pixels[loc]);
        output.pixels[loc] =  color(r, g, b); 
      }
    }

    centerX = round(width/2 - oWidth/2);
    centerY = round(height/2 - oHeight/2);
    output.updatePixels();
    image(output, centerX, centerY);
  }
}

/*
 * Select an image.
 */

void selectFile(File selection) {
  if (selection == null) {
    println("No image file has been selected.");
  } else {
    input = loadImage(selection.getAbsolutePath());
    oWidth = input.width;
    println(selection.getAbsolutePath() + "Has been selected.");
  }
}

/*
 * Make the pixels of the selected image flowing and save the new image as a .png.
 */

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      oWidth = oWidth+1;
    } else if (keyCode == DOWN) {
      oWidth = oWidth-1;
    } else if (keyCode == RIGHT) {
      oWidth = oWidth+10;
    } else if (keyCode == LEFT) {
      oWidth = oWidth-10;
    }
  }
  if(key == RETURN || key == ENTER) {
    fileName= "image_" + counter;
    output.save("outputs/" + fileName + ".png");
    println(fileName + " has been saved successfully.");
    counter++;
  }
}

/*
 * Go full screen.
 */

boolean sketchFullScreen() {
  return true;
}
