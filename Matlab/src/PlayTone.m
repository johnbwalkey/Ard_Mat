 % Example code for PullUp Resistor on Arduino
 clear
 a=arduino('COM6');
 configurePin(a, 'D12', 'pullup');
   time = 200;
   while time > 0
      speaker_status = readDigitalPin(a, 'D12');
      if speaker_status == 0
          playTone(a, 'D11', 200, 1); % was 1200
      else
          % Change duration to zero to mute the speaker
          playTone(a, 'D11', 200, 0); % was 1200 and I made 200 deeper tone
      end

     time = time - 1;
     pause(0.1);
   end
