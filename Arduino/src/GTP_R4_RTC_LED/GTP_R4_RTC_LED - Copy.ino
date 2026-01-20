#include <Wire.h>
#include <RTClib.h>
#include <Adafruit_GFX.h>
#include <Adafruit_LEDBackpack.h>

RTC_DS3231 rtc;

Adafruit_8x16matrix matrix = Adafruit_8x16matrix();

void setup() {
  Serial.begin(9600);

  if (!rtc.begin()) {
    Serial.println("Couldn't find RTC");
    while (1);
  }

  if (rtc.lostPower()) {
    Serial.println("RTC lost power, let's set the time!");
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  }

  matrix.begin(0x70); // Pass in the I2C address

  // Clear the matrix
  matrix.clear();
  matrix.writeDisplay();
}

void loop() {
  DateTime now = rtc.now();

  // Display time on the LED Matrix
  displayTime(now.hour(), now.minute());

  delay(1000); // Update every second
}

void displayTime(int hours, int minutes) {
  // Convert hours to 12-hour format
  hours = hours % 12;
  if (hours == 0) {
    hours = 12;
  }

  // Display hours
  matrix.drawChar(0, 0, hours / 10 + '0', LED_ON, LED_OFF, 1);
  matrix.drawChar(6, 0, hours % 10 + '0', LED_ON, LED_OFF, 1);

  // Display minutes
  matrix.drawChar(12, 0, minutes / 10 + '0', LED_ON, LED_OFF, 1);
  matrix.drawChar(18, 0, minutes % 10 + '0', LED_ON, LED_OFF, 1);

  // Write the changes to the display
  matrix.writeDisplay();
}

