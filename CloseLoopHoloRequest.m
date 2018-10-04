function CloseLoopHoloRequest();
clc; clear; close all force;

%removes everything from path
rmpath(genpath(['C:\Users\SLM\Documents\MATLAB\']));
rmpath(genpath(['C:\Users\SLM\Desktop\SLM_Management\']));
addpath(genpath('C:\Users\SLM\Documents\MATLAB\msocket\'));
addpath(genpath('C:\Users\SLM\Documents\GitHub\SLM-Managment\'));
addpath(genpath('C:\Users\SLM\Desktop\SLM_Management\SLM_Code\'));
addpath(genpath('C:\Users\SLM\Desktop\SLM_Management\NOVOCGH_Code\'));
addpath(genpath('C:\Users\SLM\Desktop\SLM_Management\Calib_Data\'));
%disp establishing write protocol to master
disp('done pathing')

disp('Waiting for msocket communication')
%then wait for a handshake

MasterIP = '128.32.177.217';
masterSocket = msconnect(MasterIP,3002);

invar = [];

while ~strcmp(invar,'A');
invar = msrecv(masterSocket,.5);
end;
sendVar = 'B';
mssend(masterSocket, sendVar);
disp('communication from Master To Holo Established');

x = 1;     HRin = []; 

while x>0
    HRin = msrecv(masterSocket);

    if ~isempty(HRin);
        disp('new File Detected - running HoloRequest')
        function_HR_listener(HRin,masterSocket);
    end
    
end