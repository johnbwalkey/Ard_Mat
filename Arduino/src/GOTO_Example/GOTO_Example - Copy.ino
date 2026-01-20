/* goto label; // sends program flow to the label
  Transfers program flow to a labeled point in the program.
  There are instances where a goto statement can come in handy,and simplify coding.
  One of these situations is to break out of deeply nested for loops, or if logic blocks, on a certain condition.
*/
int a=0;

void setup() {
  Serial.begin(9600);
  label:
  a++;
  Serial.println(a);
  if (a<10)
  {
    goto label;
    }
  }

void loop(){
}
