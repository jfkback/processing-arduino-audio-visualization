#include <FastLED.h>
#define NUM_LEDS 150
#define DATA_PIN 7

CRGB leds[NUM_LEDS];
char val; // Data received from the serial port

void setup() {
  Serial.begin(9600); // Start serial communication at 9600 bps
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
}

uint16_t gHue = 0;
uint8_t  gHueDelta = 50;
void loop() {
   if (Serial.available()) {
      val = Serial.read(); 
   }
   int partitions = 10;
   if (val == '1') { 
      for(int i = 0; i < NUM_LEDS; i = i + NUM_LEDS/partitions) {
        fill_solid(leds + i, (NUM_LEDS/partitions), CHSV(gHue,255, 255));
        gHue += gHueDelta; // compute new hue 
        gHue = gHue % 360;
        FastLED.delay(10);
      }
   } 
}

