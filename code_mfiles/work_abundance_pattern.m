%% print patterns for each guild by latitude 
    clear;clc
    work_compile2
%%  
[Y,I2] = sort(siteinfo(:, 2)); % site 3 at lowest latitude
 lat = siteinfo(I2, 2);  
mstyle = [1.5 7 1];
for g = 1:10
    figure
    for m = 6:8
        ind = (g_infoST(:,2)==m);
        sub1 = g_matST(ind,:);
        sub2 = log10( sub1(I2,g) + 1); % ranked from low to high latitude      
        myplot(lat, sub2, 'S', mstyle(m-5), m-5); hold on            
    end
    legend(num2month(6:8))
    script_fitpoly_1or2    
             xlabel('Latitude');
            ylabel('log_1_0(N + 1)');
                title(guildstr{g});
            axis([30 43 0 ceil(max(subg))]);
          disp(   [guildstr{g}, model])    
end
