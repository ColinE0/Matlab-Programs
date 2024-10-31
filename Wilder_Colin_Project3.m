clear
close all

d = input ('Enter the duration of the signal ');
fr = input ('Enter the frequency of the signal ');
sf = input ('Enter the sampling frequency ');
s = input ('Enter the plot point size ');

N=d*fr;
figure;
c={'red','green','blue','magenta','cyan'}
cn=1;

for i=0:1:N-1
if cn>=6
    cn=1;
end
for t=i*(1/fr)+(1/sf):1/sf:(i+1)*(1/fr);
f=cos(2*pi*fr*t);
if t>=(i-1)/fr && t<(i/fr)-(1/(2*fr))
   time=0.1;
else time = 0.3;
end

plot(t,f,'.','markersize',s,'color',c{cn});
hold on;
title(strcat('Cosine wave: frequency at ', num2str(fr) ,' Hz , sampled at ', num2str(sf),' Hz '));
xlim([0 d]);ylim([-1 1]);
grid on;
xlabel('Time (seconds)')
ylabel('Amplitude (volts)');
pause(time);

end
cn=cn+1;
end
