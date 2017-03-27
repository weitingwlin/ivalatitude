%% print patterns for each guild by latitude 
    clear;clc
    work_compile3
%%  
[Y,I2] = sort( Tsite.decimallatitude ); % site 3 at lowest latitude
 lat = Tsite.decimallatitude(I2);  
mstyle = [1.5 17 7];
%%
for g = 1:10
    figure
    for m = 6:8
        ind = (g_infoST(:,2)==m);
        sub1 = g_matST(ind,:);
        sub2 = log10( sub1(I2,g) + 1); % ranked from low to high latitude      
        myplot(lat, sub2, 'S', mstyle(m-5), m-5); hold on            
    end
    legend(num2month(6:8))
    
    subg =log10( g_matST(:,g) + 1);
    script_fitpoly_1or2    
    
             xlabel('Latitude');
            ylabel('log_1_0(N + 1)');
            guildstr = Tguildname(Tguildname.guildcode ==g,:).guildname;
                title(guildstr);
            axis([30 43 0 ceil(max(subg))]);
          disp(   [guildstr, model])    
end
