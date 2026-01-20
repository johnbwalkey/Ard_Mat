const int LEDs=3; // declaring the PMW pin where the LED is attached 

int fadeV; 

void setup()
{
pinMode (LEDs,OUTPUT);
}

void loop()

{
// grow brighter
for (fadeV=0;fadeV<256; fadeV++)
{
analogWrite(LEDs,fadeV);
delay(10);
}
//grow dimmer
for (fadeV=255;fadeV>=0;fadeV--)
{
analogWrite(LEDs, fadeV);
delay (10); //delay for 10 milliseconds
}
}

