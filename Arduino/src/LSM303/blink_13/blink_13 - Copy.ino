int ledPin = 13;    // LED connected to digital pin 13
 
/* Setup() runs only once */
void setup() {
  pinMode(ledPin, OUTPUT);    // Set pin 13 (digital) to OUTPUT mode
}

/* loop() repeats forever */
void loop() {
  digitalWrite(ledPin, HIGH);  // Set pin 13 to HIGH (5V) to turn on the pin 13's built-in LED
  delay(1000);                 // ON time delay in msec
 
  digitalWrite(ledPin, LOW);   // Set pin 13 to LOW (0V) to turn off the pin 13's built-in LED
  delay(1000);                 // OFF time delay in msec
}
