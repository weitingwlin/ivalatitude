%% script used in **work_plant_pattern.m**
% v : the variables in Tplant2
    figure
    mysubplot(5,1,2:5)
    for m = 6:8
        ind = (g_infoST(:,2) == m);
        sub1 = plantST(ind, v); % plant data is already trensformed
        sub2 = sub1(I2) ; % ranked from low to high latitude      
        myplot(latS, sub2, 'S', mstyle(m-5), m-5); hold on            
    end
    legend(num2month(6:8))
    %%%%%%%%%%%%%
    subg = plantST(:,v) ;
    script_fitpoly_1or2      
    %%%%%%%%%%%%%
            xlabel('Latitude');
          %  ylabel('log_1_0(N + 1)');    
            title( {pstring, model, ''}, 'fontsize', 10 );
          %  ylimit = ylim;
        %    if min(subg) == 0
          %      ylim([0 ylimit(2)]);
          %  end
            xlim([30 43]);
            % add a big title using my mysubplot function
  
            disp(   [Tplant2name.x___X{v}, model])    
