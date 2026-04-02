%stepper_demo

a=arduino('COM5','uno','Libraries','Adafruit/MotorShieldv2');
shield=addon(a,'Adafruit/MotorShieldV2');

TheStepperMotor=stepper(shield,1,200);

% make objects - motor is a 200 stepper


TheStepperMotor.RPM=20;
stepsPerDegree=200/360;

%  try using mod(2,10) to change steps & reverse step

degrees=10;
for i=1:100
    steps=degrees*stepsPerDegree;
    move(TheStepperMotor,round(steps));
    pause(1);
end

    