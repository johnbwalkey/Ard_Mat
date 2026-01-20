int LEDPin=9;
int buttonPin=12;
int buttonRead;
int dt=100;  //ms delay

void setup() {
Serial.begin (9600);
pinMode (LEDPin, OUTPUT);
pinMode(buttonPin,INPUT);
}

void loop() {
Serial.println (buttonRead);

buttonRead=digitalRead(buttonPin);
delay (dt);

if (buttonRead==1);{
  digitalWrite(LEDPin, LOW);
}
if (buttonRead==0);{
  digitalWrite(LEDPin, HIGH); 
}


}
