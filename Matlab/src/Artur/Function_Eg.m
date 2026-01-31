% example of function
clc
function output_1 = Calc (Num1, Num2, 1) % the 1 could be others rep add, sub, etc

if (OperationType ==1)
    output_1 =Num1+Num2;
elseif (OperationType ==2)
    output_1 =Num1-Num2;
else (OperationType ==2)
    output_1 =Num1*Num2;
end


% could use Switch and case(#) for each operation type