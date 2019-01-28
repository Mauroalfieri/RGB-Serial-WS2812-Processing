#include <Adafruit_NeoPixel.h>

#define PIN            2
#define NUMPIXELS      27

byte rgb[3]    = {127,127,127};
byte oldrgb[3] = {127,127,127};

String inputString  = "";
bool stringComplete = false;

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

void setup() {
  Serial.begin(115200);

  pixels.begin();
  for(int i=0;i<NUMPIXELS;i++){
    pixels.setPixelColor(i, pixels.Color(255,255,255));
    pixels.show();
    delay(5);
  }
  for(int i=0;i<NUMPIXELS;i++){
    pixels.setPixelColor(i, pixels.Color(0,0,0));
    pixels.show();
    delay(10);
  }
}
 
void loop() {

  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read();
    inputString += inChar;
    if (inChar == '\n') {
      stringComplete = true;
      Serial.println(inputString);
    }
  }
  
  if (stringComplete) {
    inputString = getRGB( inputString," ",0 );
    inputString = getRGB( inputString," ",1 );
    inputString = getRGB( inputString," ",2 ); 

    inputString = "";
    stringComplete = false;
  }
  
  if ( (rgb[0] != oldrgb[0]) || (rgb[1] != oldrgb[1]) || (rgb[2] != oldrgb[2]) ) {
    oldrgb[0] = rgb[0];
    oldrgb[1] = rgb[1];
    oldrgb[2] = rgb[2];

    for(int i=0;i<NUMPIXELS;i++){
      pixels.setPixelColor(i, pixels.Color(rgb[0],rgb[1],rgb[2]));
      pixels.show();
      delay(20);
    }
  }
}

String getRGB( String input, String sep, byte rgbIndex ) { 
   byte i = input.indexOf(sep);
   if ( i > 0 ) {
       rgb[rgbIndex] = input.substring(0,i).toInt();
       return input.substring(i+1);
    }
}
