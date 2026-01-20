// Puts out PWM sine wave, DC, or pulses on pin 9 of Mega board
// Controlled by serial commands:
// p - pulses, followed by 'w' (width in usec) ';' 'a' (amp in bits)';' 'f' (freq in Hz) ';' 'n' (number of pulses) ';'
// d - dc on, followed by 'a' (amp in bits)';'. send any serial character to stop it.
// s - sine wave, followed by 'f' (freq in Hz) ';' 'a' (amp in bits)';'
// dc and sine automatically engage RC filter to cut off PWM carrier

#define DT 0.024544f

void setup() 
{
  DDRH = 0xff;
  DDRA = 0xff;
  Serial.begin(115200);
  
  // Set timer 2 to fast PWM mode, and Timer counts from 0 to 255.
  // Compares OCR2B and toggles OC2B on match
  // Setting OCR2B will control duty cycle
  TCCR2A = 0b00100011;
  
  // Set counter clock to match system clock. Mega has 16 MHz clock. 
  // Freq of pulses will be 16/256 steps of counter = 62.5 kHz.
  TCCR2B = 0b00000001;
  OCR2B = 0;
  filter(0);
}

void loop() 
{
  byte i, len, c, dv=1;
  byte buf[5], sinewave[256];
  unsigned int dur, freq, width, amp, n, j;
  float tmp, sfreq;
  double sinval;
  
  c = getByte();

//  if( c == 'p' ) {
//    filter(0);
//    width = getVal('w') + 2;
//    amp = getVal('a');
//    freq = getVal('f');
//    n = getVal('n');
//    dur = 1000 / freq;
//    for(j=0; j<n; j++) {
//      OCR2B = amp;
//      delayMicroseconds(width);
//      OCR2B = 0;
//      delay(dur);
//    }
//    OCR2B = 0;  
//  }
   
   if( c == 'p' ) {
    filter(0);
    width = getVal('w') + 2;
    amp = getVal('a');
    freq = getVal('f');
    n = getVal('n');
    dur = 1000 / freq;
    for(j=0; j<n; j++) {
      OCR2B = amp;
      delayMicroseconds(width);
      OCR2B = 0;
      delay(dur);
    }
    OCR2B = 0;  
  } 
  
  else if ( c == 'd' ) {
    filter(1);
    amp = getVal('a');
    c = byte(amp);
    for(i=0; i<c; i++) {
      OCR2B = i;
      delay(27);
    }
    OCR2B = c;
    while(!Serial.available());
    for(i=c; i>0; i--) {
      OCR2B = i;
      delay(27);
    }
    OCR2B = 0;
  }

//    else if( c == 'b' ) {
//    filter(0);
//    width = getVal('w');
//    amp = getVal('a');
//    gap = getVal('g');
//    
//    //pulseint=getVal('z'); //'z' for pulse interval in millisec
//    
//   while(!Serial.available()) {
//      OCR2B = amp;
//      digitalWrite(led, HIGH);
//      delayMicroseconds(width);
//      OCR2B = 0;
//      //digitalWrite(led, LOW);
//      delayMicroseconds(gap);
//      OCR2B = amp;
//      //digitalWrite(led, HIGH);
//      delayMicroseconds(width);
//      OCR2B = 0;
//      digitalWrite(led, LOW);
//      //delayMicroseconds(dur);
//      //delay(pulseint);
//
//     //}
//    OCR2B = 0; 
//    
//    //digitalWrite(led, HIGH);
//  }
//  
  else if ( c == 's' ) {
    filter(1);
    sfreq = getFloatVal('f');
    amp = getVal('a');
    tmp = DT;
    for(j=0; j<256; j++) {
      sinval = (sin(tmp) + 1) / 2 * amp; 
      sinewave[j] = byte(sinval);
      tmp += DT;
    }
    dur = 1000000 / (sfreq*256);  
    i = 192; // when sine wave is zero so there is no transient stim
    while(!Serial.available()) {
      OCR2B = sinewave[i++];
      delayMicroseconds(dur);
    }
    while(i != 190) {
      OCR2B = sinewave[i++];
      delayMicroseconds(dur);
    }
    OCR2B = 0;
  }
  else {
    OCR2B = 0;
  }
}

byte getByte()
{  
  while( !Serial.available() );
    return Serial.read();
}

unsigned int str2int(byte *s, byte len) 
{
  unsigned int i, m;
  
  m = 1;
  i = 0;
  s = s + len - 1;
  while(len-- != 0) {
    i += m * (*s-- - 48);
    m = m * 10;
  }
  return i;
}

unsigned int getVal(byte c)
{
  byte buf[5];
  byte len = 0;
  unsigned int i;
  
  while( getByte() != c );
  while( (buf[len] = getByte()) != ';' ) {
    len++;
  }
  i = str2int(buf,len);
  return i;
}

float getFloatVal(byte c)
{
  char buf[8];
  byte len = 0;
  float f;
  
  while( getByte() != c );
  while( (buf[len] = getByte()) != ';' ) {
    len++;
  }
  buf[len] = 0;
  f = atof(buf);
  return f;
}

void filter(byte on)
{
  PORTA = 0;
  delayMicroseconds(20);
  if(on) {
    PORTA = 0x08;
  }
  else {
    PORTA = 0x02;
  }
}
