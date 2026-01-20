// Generates a double digital pulse of 200 us of +5V with a 20 us gap (0V) between
// Once the double pulse train is generated, there is 6.5 ms inter-stimulation gap.
// The system waits for 3 sec at end of a train of pulses.
// Stim on is created by request sent from Matlab

const int stimPin = 9; // to input on stimulator - pin 9 to center and GND to Shield
// if Matlab sends number '1' byte then run code
int value;

void setup()
{
  Serial.begin(9600);
  pinMode(stimPin, OUTPUT);
}
void loop() {
  if(Serial.available()>0)
     {
    value=Serial.read();
     if  (value == 1)
     {
    // if Matlab byte comes in - generate train of 150 Hz pulses

    for (int freqCount =0; freqCount <76.429; freqCount ++){ 
							// take double pulse with gap (0.42 us) plus inter-stimulation interval (6.5 ms) and repeat for 500 ms
                            // 200 us x2 plus 20 us gap is 1 pulse (so 420 us or 0.42 ms)PLUS 6.5 ms between double pulse
                            // 500 ms total stimulation divided by 6.542 = 76.429 times for loop
    
    for (int ii = 1; ii<2; ii++) { 
      // generate a double pulse for bipolar (set on stimulator (WPI A365)
      digitalWrite(stimPin, HIGH);
		delayMicroseconds(200);
		  digitalWrite(stimPin, LOW);
		delayMicroseconds(20);
      digitalWrite(stimPin, HIGH);
		delayMicroseconds(200);
      digitalWrite(stimPin, LOW);
		delayMicroseconds (6500);
      
       }
    }
    
    delay(3000); // do not allow another pulse for 3 sec?
    // do not make this value 0, otherwise code can no longer generate train pulses

  }

delay(10); // sample button state at 100 HZ frequency

    if  (value != 1)
        Serial.end();{
    // end loop
                      }
}
}



// want 500 ms stimulation (1/2 second).
// sending 2 - 200 uS pulses with 20 uS gap between PLUS 6.5 mS between pulses for 1 bipolar pulse
// 500 ms / 6.542 ms = 76.42 pulses (line for FreqCount)

// E=IR = 0.5 mA * 1 K ohm R = 0.5 Volts
  
