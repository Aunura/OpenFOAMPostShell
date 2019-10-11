clear all;clc;close all;dbstop if error;

load('postProcessing/sensorInfo');

load('postProcessing/sensorPos');
time=sensorInfo(1);
deltaT=sensorInfo(2);
lineNum=size(sensorPos,1);

%+++++++++++++++++required to input+++++++++++++++++++
propagatedDir="x";
gaugeDir="z";
plotTime=[0.2;1.4;3;4.6;8.8;14.4];
%+++++++++++++++++++++++++++++++++++++++++++++++++++++
for i=1:length(plotTime)
    if(round(rem(plotTime,deltaT)~=0))
        disp('plotTime is not integral multiple of deltaT \n');
    end
end
switch propagatedDir
    case "x"
        posIndex=1;
    case "y"
        posIndex=2;
    case "z"
        posIndex=3;
end
switch gaugeDir
    case "x"
        coordinate= "yz";
    case "y"
        coordinate= "xz";
    case "z"
        coordinate= "xy";
end
folderName_Up="postProcessing/line/";
Profile=zeros(time/deltaT,lineNum);
for i=deltaT:deltaT:time


for j=1:lineNum
    fileName=folderName_Up+i+"/line"+j+"_alpha.water."+coordinate;
    Temp=load(fileName);
    
    Pos1=Temp(:,1);
    Pos2=Temp(:,2);
    
    [alpha,index]=unique(Pos2);

    Profile(round(i/deltaT),j)=interp1(alpha,Pos1(index),0.5);

end


end

Profile=roundn(Profile,-4);

IDNum=length(plotTime)*100+10;
figure(1)
suptitle('Wave Height');
for i=1:length(plotTime)
    subplot(IDNum+i);
    plot(sensorPos(:,posIndex),Profile(round(plotTime(i)/deltaT),:),'-ob');
    xlabel(propagatedDir+" /m");
    ylabel('m');
    
    title("t="+plotTime(i),'Color','m');
  
    grid on;
end