int ledPin = 7; //This is the output pin on the Arduino
int doi;

void setup()
{
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT); //Sets that pin as an output
}
void loop()
{

  if(Serial.available()>0)
  {

    doi = Serial.read();
    //Serial.println(doi);
    //Serial.println("\n");
    //doi = doi - 48;
   if (doi == 1)
   {
    //Serial.println(1);
    digitalWrite(ledPin, HIGH); //Switch Solenoid ON
    delay(1000); //Wait 1 Second
     digitalWrite(ledPin, LOW);
    }
  else if (doi == 2)
    {
     //Serial.println(2);
    digitalWrite(ledPin, HIGH); //Switch Solenoid OFF
    delay(2000); //Wait 2 Second
    digitalWrite(ledPin, LOW);
    }
  else 
    {
      //Serial.println(3);
      digitalWrite(ledPin, HIGH); //Switch Solenoid OFF
      delay(3000); //Wait 3 Second
      digitalWrite(ledPin, LOW);
    }

  }
}
