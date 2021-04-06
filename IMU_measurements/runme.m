clear all; close all; clc;

% Connect to the arduino and IMU to gather data
ports = serialportlist;
COM = serialportlist("available");
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
s = serial(COM, 'BaudRate', 9600);
fopen(s);
%{
% define Serial Port for EEG
ports = serialportlist;
COMe = serialportlist("available");
e = serial(COMe,'BaudRate', 128000, 'DataBits', 8);
% Open port for communication
fopen(e)
%}

% Target angles {degrees}
Min = 60;
Max = 70;
Trigger = 30; % point where it starts to make 

% getting reinforcement type
feedbackquestion = 'What feedback type do you want?';
option1 = [feedbackquestion newline '1: Positive and Negative Reinforcement'];
option2 = [option1 newline '2: Positive Only Reinforcement'];
option3 = [option2 newline '3: Negative Only Reinforcement'];
option4 = [option3 newline '4: Photo Reinforcement'];
option5 = [option4 newline '5: No Reinforcement' newline];
feedbacktype = input(option5); % showing list of feedback options


% start infinite loop for data collection
disp('Close Plot to End Session!');
start = input('Start? (press enter)', 's');

% make display full screen
ss = get(0, 'ScreenSize');
figure('Position', [0 0 ss(3) ss(4)]);

% Angle graph
% User Defined Properties
tiledlayout(1,2);
t1 = nexttile;
plotTitle = 'Ankle Angle';      % plot title
xLabel = 'Elapsed Time (s)';    % x-axis label
yLabel = 'Data';                % y-axis label
plotGrid = 'on';                % 'off' to turn off grid
min = -10;                       % set y-min
max = Max+20;                      % set y-max
scrollWidth = 20;               % display period in plot, plot entire data log if <= 0
delay = .01;                    % make sure sample faster than resolution
% Define Function Variables
time = 0;
Angle = 0;
count = 0;
% Set up Plot
plotAngle = plot(t1,time,Angle,'-b','LineWidth',1,'MarkerEdgeColor','r','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);   
title(t1,plotTitle,'FontSize',25);
xlabel(t1,xLabel,'FontSize',15);
ylabel(t1,yLabel,'FontSize',15);
yline(t1,Max)
yline(t1,Min)
axis(t1,[0 10 min max]);
grid(t1,plotGrid);

% Score graph
% User Defined Properties
t2 = nexttile;
plotTitle = 'Score';            % plot title
xLabel = 'Elapsed Time (s)';    % x-axis label
yLabel = 'Score';               % y-axis label
plotGrid = 'on';                % 'off' to turn off grid
ScoreMin = -10;                       % set y-min
ScoreMax = 10;                      % set y-max
% Define Function Variables
%time = 0
score = 0;                      % initial score
% Set up Plot
plotScore = plot(t2,time,score,'-b','LineWidth',1,'MarkerEdgeColor','r','MarkerFaceColor',[.49 1 .63],'MarkerSize',2);   
title(t2,plotTitle,'FontSize',25);
xlabel(t2,xLabel,'FontSize',15);
ylabel(t2,yLabel,'FontSize',15);
axis(t2,[0 10 ScoreMin ScoreMax]);
grid(t2,plotGrid);

flag = false;
datatemp = []; % creating temperary data to find max and min angles
tic % start time counter
while ishandle(plotAngle) %Loop when Plot is Active
    % return 'Angle' between foot and shank
    dat = fscanf(s,'%f'); %Read Data from Serial as Float
    if(~isempty(dat) && isfloat(dat)) %Make sure Data Type is Correct        
        count = count + 1;    
       
        % collect time and angle
        time(count) = toc;    %Extract Elapsed Time
        Angle(count) = dat(1); %Extract 1st Data Element         
         
        
        % Finding max for feedback
        if (dat(1) > Trigger)     
            datatemp = [datatemp; dat(1)]; % create temp data
            flag = true;
        end
        if (dat(1) < Trigger && flag == true)
            tempmax = max(datatemp);
            % in: angle, score, min, max
            score(count) = feedback(feedbacktype, tempmax, score, Min, Max); % out: updated score
            %{
            % write to EEG port
            fprintf(e, 'WRITE 255\n'); 
            % insert code to run here
            fprintf(e, 'WRITE 0\n');
            %}
            datatemp = [];
            flag = false;
        end
        plotScore;

        
        %Set Axis according to Scroll Width
        if(scrollWidth > 0)
        set(plotAngle,'XData',time(time > time(count)-scrollWidth),'YData',Angle(time > time(count)-scrollWidth));
        axis(t1,[time(count)-scrollWidth time(count) min max]);
        else
        set(t1.plotAngle,'XData',time,'YData',Angle);
        axis(t1,[0 time(count) min max]);
        end
        
        %Set Axis according to Scroll Width
        if(scrollWidth > 0)
        set(plotScore,'XData',time(time > time(count)-scrollWidth),'YData',Angle(time > time(count)-scrollWidth));
        axis(t2,[time(count)-scrollWidth time(count) ScoreMin ScoreMax]);
        else
        set(plotScore,'XData',time,'YData',Angle);
        axis(t2,[0 time(count) ScoreMin ScoreMax]);
        end
        
        %Allow MATLAB to Update Plot
        pause(delay);
    end
end


%Close Serial COM Port and Delete useless Variables
fclose(s);
clear count dat delay max min plotGraph plotGrid plotTitle s ...
        scrollWidth serialPort xLabel yLabel;
disp('Session Terminated...');
echo off;