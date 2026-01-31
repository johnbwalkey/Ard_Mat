
% Control Stepper Motor V2
clear
a=arduino
%Create an addOnShield object for the V2 Motor shield a=arduino('COM8','uno','Libraries','Adafruit/MotorShieldv2');
shield=addon(a,'Adafruit/MotorShieldV2');
 
sm = stepper(shield, 2, 200)
   sm.RPM = 10;
   move(sm, 200);
   pause(2);
   move(sm, -200);	
   release(sm);

%Clean Up
clear s dcm sm shield a

%the above works - steps clockwise then counterclockwise

