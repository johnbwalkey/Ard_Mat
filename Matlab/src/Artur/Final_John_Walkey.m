% 7.
s=11;% mean
tone= std(s);
sr = 44100; %sampling rate 
f = 500; % tone freq
d = 4; %sound duration 
t = rand(s);
sound(tone, sr);
figure;hist(t,s);
pause(1)

%9
disp ('please enter 3 words pressing enter after each');
disp ('please type the words in the Command Window.');
str1 = input('Word 1 : ','s');
str2 = input('Word 2 : ','s');
str3 = input('Word 3 : ','s');
pause (3);
disp ('Thanks - you typed: ');
ans={str3 str2 str1}

%10
disp ('please type 10 random numbers between 1 and 5');
disp ('pressing enter after each');
disp ('please type the words in the Command Window.');
c=0
n=0
for c<=10;
input('number 'n)'
    if n>5
        disp ('please type number between 1 and 5');
        break
    end
    N(c)=n
end
save (jw.mat, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10);

%6
A=[5 6 7 5 7];
B=[3 4 5 6 7];
C=[8 8 8 20 25];
D=mean (A);
E=mean (B);
F=mean (C);
G=[D,E,F];
figure; bar (G,'g');
H=[5 6 7 5 7; 3 4 5 6 7; 8 8 8 20 25];
J = std(A);
K = std(B);
L = std(C);
M = [J K L];
hold on;
bar(M,'r');
legend ('Mean','STD');
lap1=A';
lap2=B';
lap3=C';
NL=[lap1 lap2 lap3];
figure; plot (G,NL);

%4
% sig_example (.m and .fig)

