int cnt=0;
void setup() {
  // put your setup code here, to run once:
Serial.begin (9600);
}

void loop() {
  // put your main code here, to run repeatedly:
Serial.print  ("I am counting ");
Serial.print (cnt);
Serial.println ("miss ");
cnt=cnt+1;
delay (1000);
}
