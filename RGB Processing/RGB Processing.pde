import processing.serial.*;

int red    = 200;
int green  = 200;
int blue   = 200;

int sRed   = 127;
int sGreen = 127;
int sBlue  = 127;

int oldsRed   = 127;
int oldsGreen = 127;
int oldsBlue  = 127;

Serial myPort;  

void setup() {
  size(290,440);
  //printArray( Serial.list() );
  myPort = new Serial(this, Serial.list()[2], 57600);
}

void draw() {
  background(sRed,sGreen,sBlue);
  
  fill(0, 0, 0);
  stroke(255, 0, 0);
  rect(30, 20, 55, 360, 5 );
  stroke(0, 255, 0);
  rect(120, 20, 55, 360, 5 );
  stroke(0, 0, 255);
  rect(205, 20, 55, 360, 5 );
    
  stroke(255, 255, 255);
  if ( mousePressed ) {
    if ( (30 < mouseX && mouseX < 86) && (46 < mouseY && mouseY < 353) ) {
      red = mouseY;
      fill(255, 0, 0);
      translate(0, red);
      rect(30, -27, 55, 55, 5 );
      translate(0, -red);
    } else {
      fill(255, 0, 0);
      rect(30, red-(55/2), 55, 55, 5 );
    }
    
    /**********************/
    
    if ( (121 < mouseX && mouseX < 177) && (46 < mouseY && mouseY < 353) ) {
      green = mouseY;
      fill(0, 255, 0);
      translate(0, green);
      rect(120, -27, 55, 55, 5 );
      translate(0, -green);
    } else {
      fill(0, 255, 0);
      rect(120, green-(55/2), 55, 55, 5 );
    }
    
    /**********************/
    
    if ( (206 < mouseX && mouseX < 263) && (46 < mouseY && mouseY < 353) ) {
      blue = mouseY;
      fill(0, 0, 255);
      translate(0, blue);
      rect(205, -27, 55, 55, 5 );
      translate(0, -blue);
    } else {
      fill(0, 0, 255);
      rect(205, blue-(55/2), 55, 55, 5 );
    }
  } else {
    fill(255, 0, 0);
    rect(30, red-(55/2), 55, 55, 5 );
    fill(0, 255, 0);
    rect(120, green-(55/2), 55, 55, 5 );
    fill(0, 0, 255);
    rect(205, blue-(55/2), 55, 55, 5 );
  }
  
  fill(255);
  rect(30, 2, 55, 15, 2 );
  rect(120, 2, 55, 15, 2 );
  rect(205, 2, 55, 15, 2 );
  
  rect(30, 385, 55, 20, 2 );
  rect(120, 385, 55, 20, 2 );
  rect(205, 385, 55, 20, 2 );
  
  rect(30, 415, 230, 20, 2 );
  
  fill(0);
  textSize(14);
  sRed   = int(map(red,47,352,255,0));
  sGreen = int(map(green,47,352,255,0));
  sBlue  = int(map(blue,47,352,255,0));
  
  text(sRed,    35, 15 );
  text(sGreen, 125, 15 );
  text(sBlue,  210, 15 );
  
  text(hex(sRed,2),    35, 400 );
  text(hex(sGreen,2), 125, 400 );
  text(hex(sBlue,2),  210, 400 );
  
  text("#" + hex(sRed,2) + hex(sGreen,2) + hex(sBlue,2),  35, 430 );
  
  if ( ( !mousePressed ) && ((sRed != oldsRed) || (sGreen != oldsGreen) || (sBlue != oldsBlue))) {
    myPort.write(Integer.toString(sRed)+" "+Integer.toString(sGreen)+" "+Integer.toString(sBlue));
    myPort.write('\n');
    println( sRed + " " + sGreen + " " + sBlue );
    println(hex(sRed,2));
    
    oldsRed   = sRed;
    oldsGreen = sGreen;
    oldsBlue  = sBlue;
  }
}

// this part is executed, when serial-data is received
void serialEvent(Serial p) {
  try {
    // get message till line break (ASCII > 13)
    String message = p.readStringUntil(13);
    // just if there is data
    if (message != null) {
      println("message received: "+trim(message));
    }
  }
  catch (Exception e) {
  }
}