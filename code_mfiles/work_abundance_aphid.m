%% print patterns for each guild by latitude 
    clear;clc
    work_compile3
%% aphid abundance
ind_aphid = any(repmat(Tguildtaxon.taxon2, 1,2) == repmat([46, 48], 178,1), 2);
aphidST = metacommunity( sum(wbugdata(:, ind_aphid), 2), ...
                                        Tplant{:, {'Sitecode', 'Monthcode'}}); 
%%  
[Y,I2] = sort( Tsite.decimallatitude ); % site 3 at lowest latitude
 lat = Tsite.decimallatitude(I2);  
mstyle = [1.5 17 7];
%%
figure
mysubplot(6,1, 2:5)
guildstr = 'aphid';
    for m = 6:8
        ind = (g_infoST(:,2) == m);
        sub1 = aphidST(ind,:);
        sub2 = log10( sub1(I2) + 1); % ranked from low to high latitude      
        myplot(lat, sub2, 'S', mstyle(m-5), m-5); hold on            
    end
    legend(num2month(6:8))
    
    subg = log10( aphidST + 1);
    script_fitpoly_1or2    
             xlabel('Latitude');
            ylabel('log_1_0(N + 1)');       
               title({['p =',  num2str(p,3)], model, ''}, 'fontsize', 10);
             %   title(guildstr);
            axis([30 43 0 ceil(max(subg))]);
          disp(   [guildstr, model])    
                    mysubplot(6,1,0, guildstr)