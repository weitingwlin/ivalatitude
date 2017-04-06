%% print patterns for plant and environment variables
    clear;clc
    work_compile3
%%  
[Y,I2] = sort( Tsite.decimallatitude ); % site 3 at lowest latitude
 latS = Tsite.decimallatitude(I2);  
mstyle = [1.5 17 7];

%% 
v = 1
   script_plant_pattern 
        ytemp = [0:10:50, 100];
         ytrans = log10(ytemp +1);
         ylim([ytrans(1), ytrans(end)])  
    set(gca, 'Ytick', ytrans)
    set(gca, 'YtickLabels', split(num2str(ytemp)))  
    ylabel( ['  (', Tplant2name.unit{v},')'])
      mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}], ...
                                       ['transformation: ( ', Tplant2name.transformation{v}, ' ) '] })    
%% Armases
v = 2
   script_plant_pattern 
        ytemp = [0:5, 10];
         ytrans = log10(ytemp +1);
         ylim([ytrans(1), ytrans(end)])  
    set(gca, 'Ytick', ytrans)
    set(gca, 'YtickLabels', split(num2str(ytemp)))  
    ylabel( ['  (', Tplant2name.unit{v},')'])
      mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}], ...
                                       ['transformation: ( ', Tplant2name.transformation{v}, ' ) '] })    

%% 
v = 3
   script_plant_pattern 
        ytemp = [0.25, 0.5:0.5: 2, 2.25];
         ytrans = log10(ytemp +1);
         ylim([ytrans(1), ytrans(end)])  
    set(gca, 'Ytick', ytrans)
    set(gca, 'YtickLabels', split(num2str(ytemp)))  
    ylabel( ['  (', Tplant2name.unit{v},')'])
      mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}], ...
                                       ['transformation: ( ', Tplant2name.transformation{v}, ' ) '] })    
%% volume
v = 4
   script_plant_pattern 
        ytemp = [0, 0.5 1:4];
         ytrans = log10(ytemp +1);
         ylim([ytrans(1), ytrans(end)])  
    set(gca, 'Ytick', ytrans)
    set(gca, 'YtickLabels', split(num2str(ytemp)))  
    ylabel( ['  (', Tplant2name.unit{v},')'])
      mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}], ...
                                       ['transformation: ( ', Tplant2name.transformation{v}, ' ) '] })    
%% v = 5 leaf toughness
v = 5
    script_plant_pattern 
         ytemp = [100, 150, 200, 300, 400, 500];
         ytrans = log10(ytemp +1);
         ylim([ytrans(1), ytrans(end)])  
    set(gca, 'Ytick', ytrans)
    set(gca, 'YtickLabels', split(num2str(ytemp)))  
    ylabel( ['  (', Tplant2name.unit{v},')'])
     mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}], ...
                                       ['transformation: ( ', Tplant2name.transformation{v}, ' ) '] })    

%% v = 6
v = 6
    script_plant_pattern 
    ylabel( ['  (', Tplant2name.unit{v},')'])
mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}] })    

%% v = 7:8
for v = 7:8
script_plant_pattern 
    ytemp = 0:0.1:0.9;
            ytrans = asin(sqrt(ytemp));
    ylim([0, ytrans(end)])  
    set(gca, 'Ytick', ytrans)
    set(gca, 'YtickLabels', split(num2str(ytemp)))    
   ylabel( ['  (', Tplant2name.unit{v},')'])
    mysubplot(4,1,0,  {'', [Tplant2name.x___X{v}], ...
                                       ['transformation: ( ', Tplant2name.transformation{v}, ' ) '] })    
end