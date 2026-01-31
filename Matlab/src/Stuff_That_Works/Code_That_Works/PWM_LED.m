%% Brighten and dim LED

% Send pulse signals of specified width to the PWM pins on the Arduino 
% hardware. PWM signals can light up LEDs connected to the pin. The duty
% cycle of the pulse controlls the brightness of the LED. Calculate the
% amount that the LED brightens and dims by dividing the max and min duty
% cycle for the pin by the number of iterations.

clear
a=arduino('com7');
   brightness_step = (1-0)/20;
   % Brighten
   for i = 1:20
      writePWMDutyCycle(a, 11, i*brightness_step);
      pause(0.1);
   end
% Dim
   for i = 1:20
      writePWMDutyCycle(a, 11, 1-i*brightness_step);
      pause(0.1);
   end
