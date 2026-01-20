/*  SD card Temperature  data logger
   SD card connections
 ** MOSI - pin 11
 ** MISO - pin 12
 ** CLK - pin 13
 ** CS - pin 10 

https://www.electroniclinic.com/
*/

// Include the libraries we need

#include <SPI.h>
#include <SD.h>
#include <Wire.h>
#include "RTClib.h"
//#include <DFRobot_MLX90614.h>
//DFRobot_MLX90614_IIC sensor;   // instantiate an object to drive our sensor


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

uint32_t LastTime=0;                // Last Time we took a reading (from ,millis())
String CoreFileName="TLog_";  // This id the core name of the file to write to, 
String FileName="";                 // The actual filename to write to based on the core name and a numeric addendum
  String DataString = "";

  
void setup() {
  bool FileFound=true;        // See end of function
  uint16_t Index=0;
  
  // Open serial communications 
  // We use this just for error reporting if problems are occuring
  Serial.begin(9600);

  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    while (1);
  }
   if (! rtc.begin()) {
    Serial.println("Couldn't find RTC");
    while (1);
  }

  if (rtc.lostPower()) {
    Serial.println("RTC lost power, lets set the time!");
  
  // Comment out below lines once you set the date & time.
    // Following line sets the RTC to the date & time this sketch was compiled
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  }
    while( NO_ERR != sensor.begin() ){
    Serial.println("Communication with device failed, please check connection");
    delay(3000);
  }
  Serial.println("Begin ok!");

  /**
   * adjust sensor sleep mode
   * mode select to enter or exit sleep mode, it's enter sleep mode by default
   *      true is to enter sleep mode
   *      false is to exit sleep mode (automatically exit sleep mode after power down and restart)
   */
  sensor.enterSleepMode();
  delay(50);
  sensor.enterSleepMode(false);
  delay(200);

  while(FileFound)
  {
    FileName=CoreFileName+String(Index)+".csv";         //.csv = Comma Seperated Values
    FileFound=SD.exists(FileName);
    Index++;
  }
  // If we get this far filename is a valid none existing file
  TakeReading();  // Initial Reading
}

void loop() {

    TakeReading();
   // You could do other stuff in the loop here if you wanted. Animate a display perhaps?
  
}


void TakeReading()
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

  //myDate = myDate +dofweek+ " "+ Day + "/" + Month + "/" + Year ; 
   myTime= Hours +":"+ Minutes +":" + Secs ; 
  // send to serial monitor
 Serial.println(dofweek); 
 Serial.println(myDate); 
 //Serial.println(myTime);

  static uint16_t Time=0;
 /**
   * get ambient temperature, unit is Celsius
   * return value range： -40 C ~ 85 C
   */
  float ambientTemp = sensor.getAmbientTempCelsius();

  /**
   * get temperature of object 1, unit is Celsius
   * return value range： -40 C ~ 85 C
   */
  float objectTemp = sensor.getObjectTempCelsius();

  // print measured data in Celsius
  Serial.print("Ambient celsius : "); Serial.print(ambientTemp); Serial.println(" C");
  Serial.print("Object celsius : ");  Serial.print(objectTemp);  Serial.println(" C");


 DataString=DataString+myDate+","+myTime+","+dofweek+","+String(objectTemp);
  
  
  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  File dataFile = SD.open(FileName, FILE_WRITE);
  // if the file is available, write to it:
  if (dataFile) {
    // If this is the first reading then put column headings in first
    if(Time==0)
      dataFile.println("Date,Time,Day,Temp");  
    dataFile.println(DataString);
    dataFile.close();
  }
  else      // if the file isn't open, pop up an error:
  {
    Serial.print("error opening ");
    Serial.println(FileName);
  }

    DataString = "";
  
   Time++;
   delay(2000);
}
