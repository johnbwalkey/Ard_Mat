
1./* 
2.turn on a IR LED when the button is pressed
3.turn it off when the button is not pressed (or released)
4.*/
5.int pinButton = 4; //the pin where we connect the button
6.int LED = 3; //the pin we connect the LED
7. 
8.void setup() {
9.  pinMode(pinButton, INPUT); //set the button pin as INPUT
10.  pinMode(LED, OUTPUT); //set the LED pin as OUTPUT
11.}
12. 
13.void loop() {
14.  int stateButton = digitalRead(pinButton); //read the state of the button
15.  if(stateButton == 1) { //if is pressed
16.     digitalWrite(LED, HIGH); //write 1 or HIGH to led pin
17.  } else { //if not pressed
18.     digitalWrite(LED, LOW);  //write 0 or low to led pin
19.  }
20.}


