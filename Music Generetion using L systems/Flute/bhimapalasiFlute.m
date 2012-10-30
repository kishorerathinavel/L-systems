%%
% Written by Kishore Rathinavel
% Music generation using L systems
%%

close all
clear all
clc


sampleRate=20000;
f1=400; f2=800; f3=1200; f4=1600; f5=2000;
duration=1/f1;
sampleLength=duration*sampleRate;
t=linspace(0,duration,sampleLength);
A1=0.032; A2=5.62e-3; A3=0.018; A4=3.16e-3; A5=1.7e-3;
y=A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t)+A4*sin(2*pi*f4*t)+A5*sin(2*pi*f5*t);
y=y/3;
sound(y,sampleRate);

%calculating how long is the waveform in terms of indices
plot(y);
title('Flute waveform');
xlabel('Index');

sampleRate=20000;
duration=0.5;
sampleLength=duration*sampleRate;
t=linspace(0,duration,sampleLength);
A1=0.032; A2=5.62e-3; A3=0.018; A4=3.16e-3; A5=1.7e-3;
f1=400; f2=800; f3=1200; f4=1600; f5=2000;
y=A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t)+A4*sin(2*pi*f4*t)+A5*sin(2*pi*f5*t);
y=y/3;
sound(y,sampleRate);


%Frequency ratios of the Srutissa1=1
sa1=1;
re1=256/243;
re2=9/8;
ga1=32/27;
ga2=5/4;
ma1=4/3;
ma2=45/32;
pa=3/2;
da1=128/81;
da2=5/3;
ni1=16/9;
ni2=15/8;
sa2=2;
st=0;

raga=[sa1 re2 ga2 pa da2 sa2];
[no ragalength]=size(raga);


%Raga Bhimapalasi rules
rule(1).before = 'g';
rule(1).after = 'gmPnS';

rule(2).before = 'S';
rule(2).after = 'gmpnSnDP';
 
rule(3).before = 'N';
rule(3).after = 'Nsgm';

rule(4).before = 'P';
rule(4).after = 'PgmgRs';
nRules = length(rule);

axiom = '<N'; 

%number of repetitions
nReps = 3;

for i=1:nReps
    
    %one character/cell, with indexes the same as original axiom string
    axiomINcells = cellstr(axiom'); 
    
    for j=1:nRules
        %the indexes of each 'before' string
        hit = strfind(axiom, rule(j).before);
        if (length(hit)>=1)
            for k=hit
                axiomINcells{k} = rule(j).after;
            end
        end
    end
    %now convert individual cells back to a string
    axiom=[];
    for j=1:length(axiomINcells)
        axiom = [axiom, axiomINcells{j}];
    end
    
end

% axiom
% Now draw the string as turtle graphics
%Upper case (e.g. F or G) causes a line to be drawn in the current direction of the turtle
%Lower case causes a move with no draw
%angle +operator means turn left; -operator means turn right

%Init the turtle

%init the turtle stack
currentpointer=1;
f0=440;
timelength=1;

saveiteration=length(axiom);
scalechange=1;
song=[];


for i=1:length(axiom)
    cmdT = axiom(i);
    if i==saveiteration+2
        scalechange=1;
    end
    flag=1;
    switch cmdT
        case ','
            pause(0.5);
        case 's'
            modifier=sa1;
            modifier=modifier*scalechange;
        case 'S'
            modifier=sa2;
            modifier=modifier*scalechange;
        case 'r'
            modifier=re1;
            modifier=modifier*scalechange;
        case 'R'
            modifier=re2;
            modifier=modifier*scalechange;
        case 'g'
            modifier=ga1;
            modifier=modifier*scalechange;
        case 'G'
            modifier=ga2;
            modifier=modifier*scalechange;
        case 'm'
            modifier=ma1;
            modifier=modifier*scalechange;
        case 'M'
            modifier=ma2;
            modifier=modifier*scalechange;
        case 'P'
            modifier=pa;
            modifier=modifier*scalechange;
        case 'd'
            modifier=da1;
            modifier=modifier*scalechange;
        case 'D'
            modifier=da2;
            modifier=modifier*scalechange;
        case 'n'
            modifier=ni1;
            modifier=modifier*scalechange;
        case 'N'
            modifier=ni2;
            modifier=modifier*scalechange;
        case '<'
            scalechange=0.5;
            saveiteration=i;
            flag=0;
        case '>'
            scalechange=2;
            saveiteration=i;
            flag=0;
        otherwise
            continue;
    end
    if flag==1
        y=A1*sin(2*pi*f1*modifier*t)+A2*sin(2*pi*f2*modifier*t)+A3*sin(2*pi*f3*modifier*t)+A4*sin(2*pi*f4*modifier*t)+A5*sin(2*pi*f5*modifier*t);
        y=y;
        % sound(y,sampleRate);
        song=[song y];  

    end
    
    
end

% song=song/max(abs(song));
wavwrite(song,sampleRate,'bhimpalasiFlute.wav');











