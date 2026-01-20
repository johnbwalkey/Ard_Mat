//------------------------------------
// Arduino LED Control via VB.NET GUI
//------------------------------------
void setup()
{
  Serial.begin(9600);
  pinMode(12, OUTPUT);
}
//------------------------------------
void loop()
{
  if(Serial.available())
  {
    String data = Serial.readString();
    int num = data.toInt();
    //---------------------------------------------------
    if(num == 0) digitalWrite(12, !digitalRead(12));
    else if(num != 0)
    {
      for(int i = 1; i <= num*2; i++)
      {
        digitalWrite(12, !digitalRead(12)); delay(300);
      }
      digitalWrite(12, LOW);
    }
  }
}
