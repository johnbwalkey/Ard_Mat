% Control a Piezo speaker using a push button 
% See Matlab Stuff that works for circuit pic
   configurePin(a, 'D12', 'pullup');
   time = 200;
   while time > 0
      speaker_status = readDigitalPin(a, 'D12');
      if speaker_status == 0
          playTone(a, 'D11', 1200, 1);
      else
          % Change duration to zero to mute the speaker
          playTone(a, 'D11', 1200, 0);
      end

     time = time - 1;
     pause(0.1);
   end
