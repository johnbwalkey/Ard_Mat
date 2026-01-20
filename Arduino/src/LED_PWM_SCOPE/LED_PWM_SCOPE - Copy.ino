int redPin=9;
int bright=50;
/* change bright value between 0 and 255 */
void setup() {
  // put your setup code here, to run once:
pinMode (redPin, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
analogWrite (redPin,bright);
}
