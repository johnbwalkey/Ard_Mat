// Generates a double digital pulse of 200 us of +5V with a 20 us gap (0V) between - when the button is pressed. 
// Once the double pulse train is generated, by button press, there is 6.5 ms inter-stimulation gap.
// The system ignores additional button press for 3 sec with 0V output at end of a train of pulses.
// Stim on is created by logical TRUE to pin 11
const int stimPin = 9; // to input on stimulator - pin 9 to center and GND to Shield
const int buttonPin = 11; // logical true - to Arduino Ground

void setup()
{
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(stimPin, OUTPUT);
}

void loop()
{
  // read the button pin
  
  if (digitalRead(buttonPin) == LOW) { 
    // if button pressed generate train of 150 Hz pulses - value 1 was value LOW (HIGH is 0)

    for (int freqCount =0; freqCount <76.429; freqCount ++){ 
							// take double pulse with gap (0.42 us) plus inter-stimulation interval (6.5 ms) and repeat for 500 ms
                            // 200 us x2 plus 20 us gap is 1 pulse (so 420 us or 0.42 ms)PLUS 6.5 ms between double pulse
                            // 500 ms total stimulation divided by 6.542 = 76.429 times for loop
    
    for (int i = 1; i<2; i++) { 
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
}

// want 500 ms stimulation (1/2 second).
// sending 2 - 200 uS pulses with 20 uS gap between PLUS 6.5 mS between pulses for 1 bipolar pulse
// 500 ms / 6.542 ms = 76.42 pulses (line for FreqCount)

// E=IR = 0.5 mA * 1 K ohm R = 0.5 Volts
  
