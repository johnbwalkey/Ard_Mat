//-------------------------------
//ATtiny85 - TEA5767 FM Receiver
//-------------------------------
#include <TinyWireM.h>
//-------------------------------
extern "C" {void delay_ms();}
//-------------------------------
#define freq_IF   225000
#define freq_ref  32768
//----------------------------------------------------------------------
float freq_RF[3] = {101.3, 104.5, 107.9}; //RF of FM stations
unsigned int PLL_word;                    //14-bit PLL word
byte write_byte[5], read_byte[5], i;      //5 write & read bytes
//========================================================================
void setup()
{
  DDRB |= (1 << PB1);   //PB1 for o/p (stereo LED indicator)
  DDRB &= ~(1 << PB3);  //PB3 for i/p (standby button 1)
  DDRB &= ~(1 << PB4);  //PB4 for i/p (station button 2)
  //---------------------------------------------------------------------
  TinyWireM.begin();    //initialize ATtiny85 USI for TWI
  //---------------------------------------------------------------------
  write_byte[2] = 0x91; //Byte 3, high side injection, stereo audio
  write_byte[4] = 0x40; //Byte 5, de-emphasis time constant 75us
  //---------------------------------------------------------------------
  standby();            //put TEA5767 in standby mode
}
//========================================================================
void loop()
{
  if(PINB & 0b00001000) standby();      //standby button pressed?
  if(PINB & 0b00010000) play_station(); //station button pressed?
}
//========================================================================
void play_station()
{
  delay_ms();                       //button press debouncing
  //---------------------------------------------------------------------
  PLL_word = 4 * (freq_RF[i] * 1000000 + freq_IF) / freq_ref;
  //---------------------------------------------------------------------
  write_byte[0] = PLL_word >> 8;   //Byte 1, mute OFF, PLL high byte
  write_byte[1] = PLL_word & 0xFF; //Byte 2, PLL low byte
  write_byte[3] = 0x9E;            //Byte 4, standby OFF, filters ON
  //---------------------------------------------------------------------
  I2C_write();                     //send bytes to TEA5767
  I2C_read();                      //read bytes from TEA5767
  //---------------------------------------------------------------------
  i++;                             //point to next FM station
  if(i == 3) i = 0;                //reset FM station counter
}
//========================================================================
void standby()
{
  delay_ms();                      //button press debouncing
  //---------------------------------------------------------------------
  write_byte[0] = 0x80;            //mute ON, search OFF, PLL high = 0
  write_byte[1] = 0x00;            //Byte 2, PLL low byte = 0
  write_byte[3] = 0x50;            //Byte 4, standby ON
  //---------------------------------------------------------------------
  I2C_write();                     //send bytes to TEA5767
  //---------------------------------------------------------------------
  i = 0;                           //reset FM station counter
  PORTB &= ~(1<<PB1);              //stereo LED OFF
}
//========================================================================
void I2C_write()
{
  TinyWireM.beginTransmission(0x60); //START condition & write address
  for(int j=0; j<5; j++) TinyWireM.send(write_byte[j]); //send 5 bytes
  TinyWireM.endTransmission();       //STOP condition
}
//========================================================================
void I2C_read()
{
  TinyWireM.requestFrom(0x60, 5); //request 5 read bytes from TEA5767
  if(TinyWireM.available())       //read 5 bytes & save in read_byte[]
  {
    for(int j=0; j<5; j++) read_byte[j] = TinyWireM.receive();
  }
  //---------------------------------------------------------------------
  read_byte[2] = (read_byte[2] & 0x80); //mask Byte 3 & keep MSB (stereo)
  if(read_byte[2] == 0x80) PORTB |= (1<<PB1); //if MSB = 1, LED ON
  else PORTB &= ~(1<<PB1);                    //else LED OFF
}
