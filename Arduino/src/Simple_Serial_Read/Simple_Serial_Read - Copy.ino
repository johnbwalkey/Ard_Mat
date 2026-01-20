int incomingByte = 0;
void setup() {
  Serial.begin(9600);
  for (int i=7; i<=12; i++){
    pinMode(i, OUTPUT);
  }
}
void loop() {
  if (Serial.available() > 0){
    incomingByte = Serial.read();
    Serial.println(incomingByte);
    switch (incomingByte){
     case 0:
      digitalWrite(5, LOW);
      break;
     case 1:
      digitalWrite(5, HIGH);
      break;
      ///////////////////////   
     case 2:
      digitalWrite(6, LOW);
      break;
     case 3:
      digitalWrite(6, HIGH);
      break; 
     ///////////////////////
    case 4:
      digitalWrite(7, LOW);
      break;
    case 5:
      digitalWrite(7, HIGH);
      break; 
     ///////////////////////
     case 6:
      digitalWrite(8, LOW);
      break;
     case 7:
      digitalWrite(8, HIGH);
      break; 
     ///////////////////////
    case 8:
      digitalWrite(9, LOW);
      break;
    case 9:
      digitalWrite(9, HIGH);
      break; 
     ///////////////////////
    case 10:
      digitalWrite(10, LOW);
      break;
    case 11:
      digitalWrite(10, HIGH);
      break; 
     ///////////////////////
    case 12:
      digitalWrite(11, LOW);
      break;
    case 13:
      digitalWrite(11, HIGH);
      break; 
     ///////////////////////
    case 14:
      digitalWrite(12, LOW);
      break;
    case 15:
      digitalWrite(12, HIGH);
      break; 
     ///////////////////////
  }
}
}
