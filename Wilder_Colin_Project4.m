
close all
clear

Fs= 40000;
dur = 3;
Ts=1/(Fs);
t=0:Ts:dur-Ts;
recording = audiorecorder(Fs,16,1);
pause(1)

recordblocking(recording,dur);
x_data = getaudiodata(recording);
plot(t,x_data);

[x,fs] = audioread('Dtmf-9.wav'); %insert audio file you'd like to play between the ('____');
Nsamps = length(x_data);

t = (1/Fs)*(1:Nsamps);

deltaU1=1/(length(t)*Ts);
F=-(1/(2*Ts)):deltaU1:(1/(2*Ts))-deltaU1;
yfft=abs(fftshift(fft(x_data)));

F=abs(F);
F=F-600;
threshold = 1000;

figure(1)
plot(F,x_data)
xlabel('Frequency (Hz)')
ylabel('Spectrum Amplitude')
title = ('Fourier spectrum of the recorded sound');
grid

figure(1)
plot(F,yfft)
axis([0,1800 0 600])
xlabel('Frequency (Hz)')
ylabel('Spectrum Amplitude')
title = ('Fourier spectrum of the recorded sound')
grid

n=floor(Nsamps/16);
f1 = Fs*(0:n-1)/n;

for i = 1:16
A(:,i) = x_data(1+(i-1)*n:n*i);
end

fft_A = fft(A);

fft_A = fft_A(1:n/2,:);


[val] = sort(fft_A);

max = ind(end,:);

max1 = ind(end-1,:);

freq1 = f1(1,max);

freq2 = f1(1,max1);

freq = [freq1 ; freq2];
freq = sort(freq);

%Numbers of low frequency changed just a little bit to provide space between the hertz but I
%really struggled getting it to seperate well enough.
for i = 1:10
j = freq(1,i);
k = freq(2,i);
if j<=697 && k>=1209
    disp('1 was recorded.')
elseif j<=730 && k<= 1336
    disp('2 was recorded.')
elseif j<=750  && k<=1477
    disp('3 was recorded.')
elseif j<=800 && k<=1209
    disp('4 was recorded.')
elseif j<=810 && k<=1336
    disp('5 was recorded.')
elseif j<=825 && k<=1633
    disp('6 was recorded.')
elseif j<=860 && k<=1209
    disp('7 was recorded.')
elseif j<=880 && k<= 1336
    disp('8 was recorded.')
elseif j<=900 && k<=1477
    disp('9 was recorded.')
else if j<=950 && k<=1336
        disp('0 was recorded.')
    end
end
end

