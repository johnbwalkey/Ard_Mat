void setup() {
  // open the serial connection at 
  // 9600 BAUD
  Serial.begin(9600); 
  // set pin 2 to be read
  pinMode(3, INPUT);
}
 
 
void loop() {
  // store the value read from pin 2
  // into a variable
  int sensorValue = digitalRead(3);
  // print that variable over the serial connection
  Serial.println(sensorValue);
}
