// SURGERY timer with LED's and Beeps
//  FN: SURGERY_Beep_LED_Timer_15Min_15Sec.ino
// Beep to start 15 minutes (greeen LED on)
// beep to signal end of 15 minutes (green LED off)
// then wait 10 seconds
// then beep and wait 15 seconds (red LED on)
// then beep (red LED off)
// then wait 10 seconds
// LOOP

int piezoPin = 7; // digital pins used & GND

void setup() {
  pinMode(8, OUTPUT); // green LED & GND
  pinMode(10, OUTPUT); // red LED & GND
}//close setup

void loop() {
  /*Tone needs 2 arguments, but can take three
    1) Pin#
    2) Frequency - this is in hertz (cycles per second) which determines the pitch of the noise made
    3) Duration - how long the tone plays
  */
//  START 15 minute timer, tone, and green LED ON
 digitalWrite(8, HIGH); // green LED on
tone(piezoPin, 1500, 500);// start 15 minutes tone
  delay(900000); // 1000 is 1 second - 60 sec in 1 min (60x15x1000=15 min)
// turn the LED off by making the voltage LOW & beep end
tone(piezoPin, 1500, 500);// stop 15 minutes tone
  digitalWrite(8, LOW);

// 10 sec delay -- 15 sec timer (Beep & red LED on)
delay(10000); // wait 10 seconds from 15 min timer to 15 sec timer
 digitalWrite(10, HIGH); // red LED on
tone(piezoPin, 1000, 600);// start 15 sec timer tone
  delay(15000); // 15 seconds (count respirations x4) 
// turn the LED off by making the voltage LOW & beep end
tone(piezoPin, 1000, 600);// stop 15 minutes tone
  digitalWrite(10, LOW);
  
delay(10000); // wait 10 sec before back to 15 min timer

  //LOOP - until Power off
}
