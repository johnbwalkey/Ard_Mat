int potentiometer = 0;
int brightness = 0;
void setup() {
pinMode (A0,INPUT);
pinMode(3, OUTPUT);
Serial.begin (9600); // turning on serial is good for debugging
}
void loop() {
potentiometer = analogRead(A0); // read value of A0 and store in pot variable
Serial.print(potentiometer);
Serial.print ("      "); // space
Serial.println(brightness);
// take 10 bit ADC read from A0 & map to 8 bit number for PWM
// HELP - reference - look up MAP function
brightness = map (potentiometer, 0,1023,0,254);
analogWrite (3, brightness); // pin 3 is PWM pin!
}
