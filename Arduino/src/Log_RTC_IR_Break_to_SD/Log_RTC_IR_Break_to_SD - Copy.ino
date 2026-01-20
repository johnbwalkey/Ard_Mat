// This program reads IR interrupted and stores the interrupted time on SD card
// Using components (RTC 3231; Adafruit microSD card module; Arduino Uno; IR unit)

#include "SD.h"  // SD card library
#include "Wire.h"  // I2C
#include "Time.h"  // Time Manipulation
#include "DS1307RTC.h"  // DS1307 RTC
int irpin = 4;  // IR sensor pin
char timedatebuf[65];  // Time and Date string buffer
int year4digit;  // 4 digit year

void setup()
{
  Serial.begin(9600);  // Serial monitor used for testing
  pinMode (irpin, INPUT);
  
  Serial.print("Initializing SD card...");
  pinMode(10, OUTPUT);
  
  if (!SD.begin(10)) {  // check if card is installed
    Serial.println("No SD Card present in module");
    return;
  }
  Serial.println("SD Card Ready");
}


void loop()
{
   tmElements_t tm;
   
   if (digitalRead (irpin) == LOW) // IR detected 
  {
    if (RTC.read(tm)) {  // Get Time/Date from RTC1307
     
      year4digit = tm.Year + 1970;  // 4 digit year variable
      
      // Format Time & Date string in timedatebuf
      sprintf(timedatebuf, "Time: %02d:%02d:%02d   Date:  %02d/%02d/%02d   Poked",tm.Hour, tm.Minute, tm.Second, tm.Day, tm.Month, year4digit);
      
      File dataFile = SD.open("poke.txt", FILE_WRITE);  // Open or Create file 

      if (dataFile) {  // Check if file exist on SD Card
         dataFile.println(timedatebuf);
         dataFile.close();  // Close file
         Serial.println(timedatebuf);
      }  
      
      else {
        Serial.println("error opening poke.txt"); // if file not on SD Card
      } 

    }

  }
  while (digitalRead (irpin) == LOW) {  // wait until IR is HIGH again
  }
  
  delay(1000); // delay to give time for IR to reset (1 sec)
}
/* to set code time to computer time use/upload:  Examples - DS1307 RTC - Set time
For IR detect -power both transmitter and receiver -data goes to Uno digital pin 4
Wire the SD card and 3231 according to specs - NOTE that the 1307 library works!!!

AFTER DELETING Poke.txt THEN MUST RELOAD THE SKETCH !!!!!!!!!!!!!!!!!!!!!!!!
*/
