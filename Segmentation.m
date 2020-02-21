close all; clc;

%% LOADING-SAVING PATHS
PathL = 'C:\Users\mtawf\Desktop\Polar Experiments\Trial 1 (9 Minutes at rest minimum movement)'; %Path to load files
PathS = 'C:\Users\mtawf\Desktop\Polar Experiments\Trial 1 (9 Minutes at rest minimum movement)'; %Path to save files
%% EXPLANATION
% This code takes the .txt files exported by the app "Polar Sensor Logger"
% and convert them to .mat files with timestrace in nanoseconds, time in ms
% and values of HR and ECG.

%% COMENTS OF THE APP's CREATOR ABOUT "Polar_H10_XXXX_HR.txt" files
%In H10 the columns are as this:
%1:    Timestamp
%2:    Heartrate
%3..n: RR-intervals (milliseconds)
%If you have very high heart rate, eg. 140, you'll get 2-3 RR-intervals 
%per line. If you have low heartrate, eg. 50, you will get RR-intervals 
%in every other row.

%% LOAD HR FILE
% HR values are wrong exported? maybe they are not in bpm? values too big?
HR_file = dir([PathL,'\','*HR.txt']);
fid = fopen([PathL,'\',HR_file.name],'r');
if fid<0
    display('error opening file ',HR_file.name);
end
%Read file as a set of strings, one string per line
oneline = fgets(fid);
oneline = fgets(fid);%two times to avoid first row
counter=1;
while ischar(oneline)
    idx = strfind(oneline,' ');%find index of spaces in the line
    HR.timestamp_ns(counter,1) = str2double(oneline(1:idx(1)-1));
    HR.bpm(counter,1) = str2double(oneline(idx(1)+1:idx(1)+1+2));%not in bpms?
    oneline = fgets(fid);
    counter=counter+1;
end
fclose(fid);   

% Change timestamp to ms
HR.time_ms = (HR.timestamp_ns-HR.timestamp_ns(1))/(10^6);
figure(1),plot(HR.time_ms,HR.bpm)
title('HR');xlabel('time m\_s');ylabel('HR (bmp ?)')
clear('counter','fid','HR_file','idx','oneline')
%% LOAD ECG FILE

ECG_file = dir([PathL,'\','*ECG.txt']);
fid = fopen([PathL,'\',ECG_file.name],'r');
if fid<0
    display('error opening file ',ECG_file.name);
end
%Read file as a set of strings, one string per line
oneline = fgets(fid);
oneline = fgets(fid);%two times to avoid first row
counter=1;
while ischar(oneline)
    idx = strfind(oneline,' ');%find index of spaces in the line
    ECG.timestamp_ns(counter,1) = str2double(oneline(1:idx(1)-1));
    ECG.v(counter,1) = str2double(oneline(idx(1)+1:end));%not in bpms?
    oneline = fgets(fid);
    counter=counter+1;
end
fclose(fid); 

% Change timestamp to ms and interpolate to have the same sampling rate
ECG.time_ms = (ECG.timestamp_ns-ECG.timestamp_ns(1))/(10^6);
linearTimetrace = linspace(ECG.time_ms(1), ECG.time_ms(end), length(ECG.v));
linearEcgSignal = interp1(ECG.time_ms,ECG.v, linearTimetrace)';
%replacing in final values
ECG.v = linearEcgSignal;
ECG.time_ms = linearTimetrace';
Array = xlsread( 'PPG_derv.xlsx' );
col1 = Array (:, 1);

%plot a segment of the signal
% fs = 20;%Is it the real sampling rate? For better visualization recommended Sampling rate between 20 to 25 
% sec = 45; 
% dots = sec*fs;%how many dots in the seconds selected
segment = (size(ECG.time_ms,1)/12);% To find the middle of the signal divide by 2 % 45 sec segment so we divide by 12
figure(2), plot(ECG.time_ms(1:floor(segment), 1), ECG.v(1:floor(segment), 1))% floor() is used to eliminate the fraction caused by segment
title('ECG');xlabel('time m\_s');ylabel('mV?')
[c,lags] = xcorr(ECG.v(1:floor(segment)), col1);
figure(3),plot(col1)
title('PPG');xlabel('Time /s');ylabel('PPG signal')
figure(4),plot(lags, c)
title('Cross Correlation');

clear('ECG_file','M','sec','dots','segment','c','lags','Array')
%% LOAD ACC FILE
% Acc is accelerometer values: x,y and z axis.
ACC_file = dir([PathL,'\','*ACC.txt']); 
M = importdata([PathL,'\',ACC_file.name]);%DB: M = readmatrix(ECG_file.name);%readmatrix not defined
ACC.timestamp = M.data(:,1);
ACC.x = M.data(:,2);
ACC.y = M.data(:,2);
ACC.z = M.data(:,2);

%plot some seconds in the middle of the signal
fs = 25;%25 sampling rate, selected when data acquisition?
sec = 20;
dots = sec*fs;%how many dots in the seconds selected
segment = (size(ACC.timestamp,1)/2);%find the meadle of the signal
figure(5),
subplot(1,3,1),plot(ACC.timestamp(segment:segment+dots,1),ACC.x(segment:segment+dots,1)),legend('x');
subplot(1,3,2),plot(ACC.timestamp(segment:segment+dots,1),ACC.y(segment:segment+dots,1)),legend('y');
subplot(1,3,3),plot(ACC.timestamp(segment:segment+dots,1),ACC.z(segment:segment+dots,1)),legend('z');
clear('ACC_file','M','sec','dots','meadle')
