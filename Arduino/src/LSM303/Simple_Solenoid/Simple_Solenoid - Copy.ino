const int transistorPin = 9;    // connected to the base of the transistor

 void setup() {
   // set  the transistor pin as output:
   pinMode(transistorPin, OUTPUT);
 }

 void loop() {
   digitalWrite(transistorPin, HIGH);
   delay(2000);
   digitalWrite(transistorPin, LOW);
   delay(2000);
 }
