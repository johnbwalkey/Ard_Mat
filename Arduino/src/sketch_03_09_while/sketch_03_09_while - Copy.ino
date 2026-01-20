// sketch 03-09
int ledPin = 13;
int delayPeriod = 1000;
int count=0;
int i=0;

void setup() {
  pinMode(ledPin, OUTPUT);
}

void loop(){
while (1<20); // THIS makes run once !!!

 digitalWrite(ledPin, HIGH);
 delay(delayPeriod);
 digitalWrite(ledPin, LOW);
 delay(delayPeriod);
 i ++;
 if (count == 20) {
   count = 0;
   delay(3000);
 // while (1){} // this makes it just run once
 }
}
