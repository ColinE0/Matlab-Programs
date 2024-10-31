clear a
clear s

a = arduino;
s = servo (a, 'D10');


ii=0;
tempF = zeros(1e4,1);
t = zeros(1e4,1);
c = colormap('jet');

counter = 0;

tic
hold on


while toc < 40
    
    ii = ii + 1;
    v = readVoltage(a,'A0');
    disp(v);
    tempC = (v - 0.5)*10;
    tempF = 9/5*tempC+32;
    fprintf('Temperature Reading:\n  %.1f °C\n  %.1f °F\n',tempC,tempF)
    t(ii)=toc;
    plot(counter,tempF,'rx','LineWidth',2);
    ylim = [1 75];
    xlim = [1 100];
   
    counter = counter + 1;

%red
if (tempC >= 21 && tempC <= 23)
    writePosition(s,0);
    writePWMVoltage(a,'D6',5);
    writePWMVoltage(a,'D5',0);
    writePWMVoltage(a,'D3',0);
end


% yellow
if (tempC >= 19 && tempC <=20.5)
    writePosition(s,0);
    writePWMVoltage(a,'D6',5);
    writePWMVoltage(a,'D5',5);
    writePWMVoltage(a,'D3',0);
end


% green
if (tempC >=18 && tempC <= 18.5)
    writePosition(s,0.5);
    writePWMVoltage (a,'D6',0);
    writePWMVoltage (a,'D5',5);
    writePWMVoltage (a,'D3',0);
end



%cyan
if (tempC >= 16.5 && tempC <= 17.5 )
    writePosition(s,1);
    writePWMVoltage (a,'D6',0);
    writePWMVoltage (a,'D5',5);
    writePWMVoltage (a,'D3',5);
end


% blue
if (tempC < 15.5)
    writePosition(s,1);
    writePWMVoltage (a,'D6',0);
    writePWMVoltage (a,'D5',0);
    writePWMVoltage (a,'D3',5);
end


end
