// Nose Poke Logger AND write to SD card
// for SD card
  #include <SD.h>
  File myFile;
// for IR Beam Break
  define SENSORPIN 4
// Setup RTC Adafruit DS 3231
  #include "RTClib.h"
  RTC_DS1307 rtc;

void setup() 
// setup SD card Write
{
  Serial.begin(9600);

   pinMode(10, OUTPUT);
 
  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  myFile = SD.open("JWLogger.txt", FILE_WRITE);
 
  // if the file opened okay, write to it:
  if (myFile) {
    Serial.print("Writing to test.txt...");
    myFile.println("testing 1, 2, 3.");
	// close the file:
    myFile.close();
    Serial.println("done.");
  }
}     
  // initialize the sensor pin as an input:
  {
  pinMode(SENSORPIN, INPUT);     
  digitalWrite(SENSORPIN, HIGH); // turn on the pullup
  }

void loop() 
{
  // read the state of the sensor pin
    sensorState = digitalRead(SENSORPIN);
  // check if the sensor beam is broken
  // if it is, the sensorState is LOW:
    if (sensorState == LOW) {     
  // get time stamp
    } 
// Get RTC Stamp
{
    DateTime now = rtc.now();

    Serial.print(now.year(), DEC);
    Serial.print('/');
    Serial.print(now.month(), DEC);
    Serial.print('/');
    Serial.print(now.day(), DEC);
    Serial.print(" (");
    Serial.print(now.hour(), DEC);
    Serial.print(':');
    Serial.print(now.minute(), DEC);
    Serial.print(':');
    Serial.print(now.second(), DEC);
    Serial.println();
}
//write time stamp to SD