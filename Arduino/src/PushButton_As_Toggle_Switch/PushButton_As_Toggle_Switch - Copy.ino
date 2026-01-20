 // from Paul McWhorter
// https://www.youtube.com/watch?v=aMato4olzi8&list=PLGs0VKk2DiYw-L-RibttcvK-WBZm8WLEP&index=28&t=16s

int LEDState=0;
int LEDPin=8;
int buttonPin=12;
int buttonNew;
int buttonOld=1;
int dt=100;  // delay time is 100ms

void setup() {
Serial.begin (9600);
pinMode (LEDPin, OUTPUT);
pinMode (buttonPin, INPUT);
}

void loop() {
buttonNew=digitalRead (buttonPin);
if (buttonOld==0 && buttonNew==1){
  if (LEDState==0){
    digitalWrite (LEDPin, HIGH);
    LEDState=1;
  }
  else {
    digitalWrite (LEDPin, LOW);
    LEDState=0;
  }
}
buttonOld=buttonNew;
}
