%% print patterns for plant and environment variables
    clear;clc
    work_compile3
%%  
[Y,I2] = sort( Tsite.decimallatitude ); % site 3 at lowest latitude
 lat = Tsite.decimallatitude(I2);  
mstyle = [1.5 17 7];
%%
for v = 1 :8 % variables  
    figure
    for m = 6:8
        ind = (g_infoST(:,2)==m);
        sub1 = plantST(ind, v); % plant data is already trensformed
        sub2 = sub1(I2) ; % ranked from low to high latitude      
        myplot(lat, sub2, 'S', mstyle(m-5), m-5); hold on            
    end
    legend(num2month(6:8))
    %%%%%%%%%%%%%
    subg = plantST(:,v) ;
    script_fitpoly_1or2      
    %%%%%%%%%%%%%
            xlabel('Latitude');
          %  ylabel('log_1_0(N + 1)');    
            title(Plant_namestr{v});
            ylimit = ylim;
            if min(subg) == 0
                ylim([0 ylimit(2)]);
            end
            xlim([30 43]);
            
            disp(   [Plant_namestr{v}, model])    
end
