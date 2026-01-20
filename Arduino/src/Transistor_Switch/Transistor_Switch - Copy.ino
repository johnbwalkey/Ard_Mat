//************************Arduino Code ******************************
//This example code was used on the Forcetronics YouTube Channel to demonstrate how to

//make an inverter or not gate using an NPN and PNP transistor. This code is open for
//anybody to use or modify

const int BJT = 2; //create variable to control the base of NPN and PNP

void setup() {
  pinMode(BJT, OUTPUT);   // set it as digital output
}

void loop() {
  digitalWrite(BJT, LOW);   // set base of NPN and PNP to low
  delay(3000);
  digitalWrite(BJT, HIGH);   // set base of NPN and PNP to high
  delay(3000);
}
