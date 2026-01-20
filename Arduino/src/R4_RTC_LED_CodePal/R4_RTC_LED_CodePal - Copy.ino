// https://codepal.ai/code-generator/query/A1SAwgN3/arduino-uno-r4-rtc-clock-led-matrix

#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_LEDBackpack.h>
#include <RTClib.h>

RTC_DS1307 rtc;
Adafruit_8x12matrix matrix = Adafruit_8x12matrix();

void setup() {
  // Initialize the I2C communication.
  Wire.begin();
  // Initialize the RTC clock.
  rtc.begin();

  // Check if the RTC clock is running. If not, set the time.
  if (!rtc.isrunning()) {
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  }

  // Initialize the LED matrix.
  matrix.begin(0x70);
  matrix.setBrightness(15);
}

void loop() {
  // Get the current time from the RTC clock.
  DateTime now = rtc.now();

  // Display the time on the LED matrix.
  displayTime(now.hour(), now.minute());

  // Wait for 1 second before updating the display.
  delay(1000);
}

void displayTime(int hour, int minute) {
  // Clear the LED matrix display.
  matrix.clear();

  // Calculate the position of the hour and minute digits on the display.
  int hourX = 0;
  int minuteX = 4;

  // Display the hour digits.
  displayDigit(hour / 10, hourX);
  displayDigit(hour % 10, hourX + 4);

  // Display the minute digits.
  displayDigit(minute / 10, minuteX);
  displayDigit(minute % 10, minuteX + 4);

  // Update the LED matrix display.
  matrix.writeDisplay();
}

void displayDigit(int digit, int position) {
  // Define the segment patterns for each digit.
  static const uint16_t digitPatterns[] = {
    0b1111110000000000, // 0
    0b0110000000000000, // 1
    0b1101101000000000, // 2
    0b1111001000000000, // 3
    0b0110011000000000, // 4
    0b1011011000000000, // 5
    0b1011111000000000, // 6
    0b1110000000000000, // 7
    0b1111111000000000, // 8
    0b1111011000000000  // 9
  };

  // Set the segment pattern for the specified digit at the given position.
  matrix.drawPixel(position, 0, (digitPatterns[digit] & 0b1000000000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 1, (digitPatterns[digit] & 0b0100000000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 2, (digitPatterns[digit] & 0b0010000000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 3, (digitPatterns[digit] & 0b0001000000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 4, (digitPatterns[digit] & 0b0000100000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 5, (digitPatterns[digit] & 0b0000010000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 6, (digitPatterns[digit] & 0b0000001000000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 7, (digitPatterns[digit] & 0b0000000100000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 8, (digitPatterns[digit] & 0b0000000010000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 9, (digitPatterns[digit] & 0b0000000001000000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 10, (digitPatterns[digit] & 0b0000000000100000) ? LED_ON : LED_OFF);
  matrix.drawPixel(position, 11, (digitPatterns[digit] & 0b0000000000010000) ? LED_ON : LED_OFF);
}
