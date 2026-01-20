// Simple exapmple Millis from Prog Elect Academy
const byte buttonPin(5);

void setup() {
Serial.begin(9600);
}

void loop() {

 Serial.println ("This is basic line");
delay (1000);
 // Check if button pressed
 if (digitalRead(buttonPin)== LOW){
  Serial.println("Button pressed ******");
 }
}
