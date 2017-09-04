%% print patterns for each guild by latitude 
    clear;clc
    work_compile3
%%  
[Y,I2] = sort( Tsite.decimallatitude ); % site 3 at lowest latitude
 latI2 = Tsite.decimallatitude(I2);  
mstyle = [1.5 17 7];
  tab = cell(10, 4);
%%
for g = 1:10
         guildstr = Tguildname(Tguildname.guildcode ==g,:).guildname;
         ystr = guildstr;
         row = g;
    figure
   % mysubplot(6,1,2:5)
   mysubplot(1, 5,2:5)
    for m = 6:8
        ind = (g_infoST(:,2)==m);
        sub1 = g_matST(ind,:);
        sublat = Tsite.decimallatitude(g_infoST(ind,1));
        [Y,I3] = sort(sublat);
        sub2 = log10( sub1(I3,g) + 1); % ranked from low to high latitude      
        latI3 = sublat(I3);  
        myplot(latI3, sub2, 'S', mstyle(m-5), m-5); hold on            
    end
  %  legend(num2month(6:8))
     
    subg =log10( g_matST(:,g) + 1);
    script_fitpoly_abundance
    
            xlabel('Latitude');
            ylabel({'Density (ind./m^2)','log_1_0(N + 1)'});
            
      
                title(guildstr);
            %     title({pstring, model, ''}, 'fontsize', 14);
            axis([30 43 0 ceil(max(subg)*2)/2]);
          disp(   [guildstr, model])    
        %  mysubplot(6,1,0, guildstr)
end
%%
   tab = cell2table(tab, 'VariableNames', {'Guild',  'Model', 'adjRsquare', 'p'});
   writetable(tab, 'guilds.csv')
 
