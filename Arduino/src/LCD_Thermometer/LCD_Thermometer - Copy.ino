// LCD Thermister
// https://www.circuitbasics.com/arduino-thermistor-temperature-sensor-tutorial/
// UNO, Ethernet  A4 (SDA), A5 (SCL)
#include <Wire.h>
// #include <LiquidCrystal.h>
#include "LiquidCrystal_I2C.h"

int ThermistorPin = 0;
int Vo;
float R1 = 10000;
float logR2, R2, T;
float c1 = 1.009249522e-03, c2 = 2.378405444e-04, c3 = 2.019202697e-07;

// Creates an LCD object. Parameters: (rs, enable, d4, d5, d6, d7)
// LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
LiquidCrystal_I2C lcd(0x27,16,2); // set the LCD address to 0x27 for a 16 chars and 2 line display
void setup() {
lcd.init(); // initialize the lcd
lcd.backlight();
Serial.begin(9600);
}

void loop() {

  Vo = analogRead(ThermistorPin);
  R2 = R1 * (1023.0 / (float)Vo - 1.0);
  logR2 = log(R2);
  T = (1.0 / (c1 + c2*logR2 + c3*logR2*logR2*logR2));
  T = T - 273.15;
  T = (T * 9.0)/ 5.0 + 32.0; 

  lcd.print("Temp = ");
  lcd.print(T);   
  lcd.print(" F");
  
  delay(500);            
  lcd.clear();
}
