#include <SPI.h>
#include <Wire.h>
#include <U8glib.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
//---------------------------------------------------------------
#define BUZZER  10      // buzzer pin
#define MIN_BPM 20      // minimum bpm value
#define MAX_BPM 240     // maximum bpm value
#define POT A0          // pot analog pin
//-----MEGA: SDA (20); SCL (21); ****** USE THISas I used Mega

int bpm;                // bpm value

void setup() {
  
  pinMode(BUZZER, OUTPUT);  // buzer pin as output
  display.begin(U8GLIB_SSD1306_SWITCHCAPVCC, 0x3C);
}
//---------------------------------------------------------------

void loop() {

    bpm = map(analogRead(POT), 0, 1023, MIN_BPM, MAX_BPM);  
    display.clearDisplay();
    display.setTextSize(3);
    display.setTextColor(WHITE);
    display.setCursor(0,0);
    display.println(bpm);
    display.display();
    tone(BUZZER, 2000);       // does a "tick" for...
    delay(6000 / bpm);        // 10% of T (where T is the time between two BPSs)
    noTone(BUZZER);           // silence for...
    delay(54000 / bpm);       // 90% of T

}
