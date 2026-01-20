// Example Millis() from https://www.youtube.com/c/ProgrammingElectronicsAcademy/videos

// Sensors
const byte LDR = A2; // Light dependent resistor
const byte tempSensor = A4; // LM34 temp sensor
// two independant timed events
const unsigned long eventTime_1_LDR = 1000; //interval in ms
const unsigned long eventTime_2_temp = 5000; 

unsigned long previousTime_1 = 0; // millis gets big so use 'unsigned' to have big numbers
unsigned long previousTime_2 = 0;

void setup() {
Serial.begin (9600);
}

void loop() {
  // updates frequently
unsigned long currentTime = millis();
  // Event 1 Stuff
  if(currentTime - previousTime_1 >= eventTime_1_LDR){
    Serial.print ("LDR: ");
    Serial.println (analogRead(LDR) );
    // Update timing for the next event
    previousTime_1 = currentTime;
    }
  // Event 2 Stuff
    if(currentTime - previousTime_2 >= eventTime_2_temp){
    Serial.print ("Temp: ");
    Serial.println (analogRead(tempSensor) );
    // Update timing for the next event
    previousTime_1 = currentTime;
    }
}
