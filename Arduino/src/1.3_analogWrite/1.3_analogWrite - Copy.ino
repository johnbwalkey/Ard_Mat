int ledPin = 9;    

void setup() {
  
}

void loop() {
  for (int value = 0 ; value <= 255; value += 75) {
    analogWrite(ledPin, value);
    delay(50);
  }
}
