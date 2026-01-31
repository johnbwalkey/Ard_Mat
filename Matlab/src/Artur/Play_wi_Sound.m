% play with sound

sr=44100; % sampling rate
d=1; % duration of sound - 1 second
noise = rand(1, sr*d);
figure; plot (noise)
sound(noise, sr) % play noise

return

sr= 44100 % sampling rate
f=4000 % tone frequuency
d=1; % sound duration
t= linspace (0, d, sr*d);
tone=sin(2*pi*f*t)
sound (tone, sr); %play tone
figure; plot (tone)


return
%exercise play 3 tones - replace the f valuse - copy code 3 times
f1=260 % mi
f2=293 % re
f3= 329 % do

    d=1; % sound duration
    t= linspace (0, d, sr*d);
    tone1=sin(2*pi*f1*t)
    tone2=sin(2*pi*f2*t)
    tone3=sin(2*pi*f3*t)
    tonetotal =[tone1 tone2 tone3]
    sound (tone, sr); % play tone

return

% wave write - wawrite
wawrite (tonetotal, sr, 'do re mi.wav') % save sound in wave format
[tones, sr] = waread ('do re me .wav'); % read file
sound(tones, sr)
sound(tones sr/10) % sound slower


% plot sound
web_sound_rev=web_sound(end:-1:1, :);
sound(web_web_rev, sr)
figure; plot (web_sound_rev)
% maybe check flipud, fliplr for reversing vector
