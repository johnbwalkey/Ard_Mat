//RTC LOG IR POKE to SD card JBW

/*  
  SD card connections to Uno
  CLK -pin 13
  D0 - pin 12
  D1 - pin 11
  CS - pin 10 
*/

// Include these libraries:
#include <SPI.h>
#include <SD.h>
#include <Wire.h>
#include "RTClib.h"

RTC_DS3231 rtc;

char daysOfTheWeek[7][4] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
String Day; 
String Month;
String Year; 
String Secs;
String Minutes;
String Hours;

String dofweek; // day of week
String myDate; 
String myTime; 
const int chipSelect = 10;  // for SD card

uint32_t LastTime=0;                // Last Time tooking a reading (from ,millis())
String CoreFileName="TLog_";        // This id is the core name of the file to write to 
String FileName="";                 // The actual filename to write to based on the core name and a numeric addendum
String DataString = "";

// IR Pin setup
#define SENSORPIN 4 // digital pin on Uno
int sensorState = 0, lastState=0; // variables to read pokes
File dataFile;

void setup() {
  bool FileFound=true;        // See end of function
  uint16_t Index=0;  

  pinMode (SENSORPIN, INPUT); // Initialize sensor pin as an input
  digitalWrite (SENSORPIN, HIGH); // turn on pullup resistor

  pinMode(10, OUTPUT); // set SD card as data output
  dataFile = SD.open("Data.txt", FILE_WRITE);
  FileName=CoreFileName+String(Index)+".csv";   //.csv = Comma Seperated Values
  Index++;
    // close the file:
    //   dataFile.close();

  Serial.begin (9600);
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
}
void loop()
{
  DateTime now = rtc.now();
  Day = now.day(); 
  Month = now.month(); 
  Year = now.year();
  Secs = now.second(); 
  Hours = now.hour(); 
  Minutes = now.minute(); 
  dofweek = daysOfTheWeek[now.dayOfTheWeek()];  
  myDate = Day + "/" + Month + "/" + Year ; 

  myDate = myDate +dofweek+ " "+ Day + "/" + Month + "/" + Year ; 
  myTime= Hours +":"+ Minutes +":" + Secs ; 
  // send to serial monitor
 Serial.println(dofweek); 
 Serial.println(myDate); 
 Serial.println(myTime);

  static uint16_t Time=0;

/*
   read IR sensor for nose poke
   apply power to both send IR & detect IR
   data pin is SENSORPIN 4
*/
sensorState = digitalRead(SENSORPIN);
 if (sensorState == LOW) {  
    (sensorState && !lastState);
    Serial.println ("unbroken");
  }
  if (sensorState == HIGH) {
    (sensorState && lastState);
    Serial.println ("Broken");
  }
    lastState = sensorState;
 // float objectState = sensorState();

  Serial.print("Nose poke IR : ");
  Serial.print(lastState);
  DataString=DataString+myDate+","+myTime+","+dofweek+","+String(lastState);
  
  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.

  File dataFile = SD.open(FileName, FILE_WRITE);

  // if the file is available, write to it:
    if(Time==0) {
    dataFile.println("Date,Time,Day,IR State");  
    dataFile.println(DataString);
    dataFile.close();
  }

    DataString = "";
  
   Time++;
   
  delay (2000); // wait 2 seconds
}
   
