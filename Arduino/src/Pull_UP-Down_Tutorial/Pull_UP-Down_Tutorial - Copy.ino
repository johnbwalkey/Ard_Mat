// Pull-up and Pull-down Resistor Tutorial - ForceTronics Youtube
//
// the purpose of pull-up or down is 
//so an input or output is not at an unknow state

void setup(){ 
pinMode (6, INPUT_PULLUP);
pinMode (5, INPUT);
pinMode (4, INPUT);
pinMode (3, INPUT);
Serial.begin (9600);
}
void loop(){
Serial.print("This is Pull-Up input D6 ");
Serial.println (digitalRead (6));
Serial.print("This has NO Pull-Up input D5 ");
Serial.println (digitalRead (5));
Serial.print("This has NO Pull-Up input D4 ");
Serial.println (digitalRead (4));
Serial.print("This is unset pin also - D3 ");
Serial.println (digitalRead (3));

Serial.println();  // blank line
delay (1500);
}
