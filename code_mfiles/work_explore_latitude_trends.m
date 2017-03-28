%%  **work\_explore\_latitude\_trend.m**
%% preparing data
    clear;clc
    work_compile3
    mcolor = [12 37 8];
    latS = Tsite.decimallatitude;
%% problem with missing sample
% number of sample
    nsample = metacommunity(guildmat,Tplant{:, {'Sitecode', 'Monthcode'}} , 'count'); 
 %   ind_lesssample = find(nsample == 4);
% 
%% richness
figure
    richnessST = sum(  t_matST > 0, 2);
   mysubplot(1, 5, 0, 'Richness')
    name = 'richness';    

    % plot by month
    mysubplot(1,7,[2 3 ],'', [],0.1)
    for m = 6:8
                ind = t_infoST(:,2) == m;   
                Ydata =  richnessST(ind); 
                Ydata = Ydata(nsample(ind) ~= 4);
                    Xdata = Tsite.decimallatitude;   
                 Xdata = Xdata(nsample(ind) ~= 4);
            script_fitpoly_latitude_trends         
    end
     xlim([30 43])
    xlabel('latitude'); ylabel({'Taxon',name});
%   
    g_richnessST = sum(  g_matST > 0, 2);
   mysubplot(1,7,[5 6],'', [], 0.1)
   for m = 6:8
                ind = g_infoST(:,2) == m;   
           Ydata =  g_richnessST(ind);
             Ydata = Ydata(nsample(ind) ~= 4);
                    Xdata = Tsite.decimallatitude;   
                 Xdata = Xdata(nsample(ind) ~= 4);    
            script_fitpoly_latitude_trends         
    end
    script_latitude_trends_legend
   xlim([30 43])
   xlabel('latitude'); ylabel({'Guild',name});
%% diversity (Shannon)
figure
mysubplot(1, 5, 0, 'Shannon diversity')
 name = 'Shannon';    
    shannonST = D_ind_shannon(t_matST);
   % Xdata = Tsite.decimallatitude;   
    % plot by month
    mysubplot(1,7,[2 3],'', [], 0.1)
    for m = 6:8
                ind = t_infoST(:,2) == m;   
           Ydata =   shannonST(ind);
               Ydata = Ydata(nsample(ind) ~= 4);
                    Xdata = Tsite.decimallatitude;   
                 Xdata = Xdata(nsample(ind) ~= 4);
            script_fitpoly_latitude_trends         
    end
   xlim([30 43])
   xlabel('latitude'); ylabel({'Taxon', 'diversity'});
   %%%%%%
   g_shannonST = D_ind_shannon(g_matST);
      mysubplot(1,7,[5 6],'', [], 0.1)
   for m = 6:8
                ind = g_infoST(:,2) == m;   
           Ydata =  g_shannonST(ind);
                Ydata = Ydata(nsample(ind) ~= 4);
                    Xdata = Tsite.decimallatitude;   
                 Xdata = Xdata(nsample(ind) ~= 4);
            script_fitpoly_latitude_trends         
   end   
    script_latitude_trends_legend
       xlim([30 43])
          xlim([30 43])
   xlabel('latitude'); ylabel({'Guild', 'diversity'});
%% Mean rank shift /latitude
figure
mysubplot(1, 2, 0, 'Mean Rank Shift (MRS)')
name = 'MRS';    
    %Xdata = Tsite.decimallatitude;   
    % plot by month
    mysubplot(1,2,1,'', [], 0.4)
    for m = 6:8
                ind = t_infoST(:,2) == m;   
            [Ydata, Xdata, dif] = mean_rank_shift(t_matST(ind,:), Tsite.decimallatitude, 2);
            Ydata = Ydata(:) ;%./ dif(:);
                 Xdata = Xdata(:);
                
            script_fitpoly_latitude_trends         
    end
            xlim([30 43])
   xlabel('latitude'); ylabel({'Taxon', 'MRS'});
   %%%%%%
 %  g_shannonST = D_ind_shannon(g_matST);
     mysubplot(1,2,2,'', [], 0.4)
   for m = 6:8
                ind = g_infoST(:,2) == m;   
            [Ydata, Xdata, dif] = mean_rank_shift(g_matST(ind,:), Tsite.decimallatitude,2);
                Ydata = Ydata(:) ;%./ dif(:);
                Xdata = Xdata(:);
                
            script_fitpoly_latitude_trends         
   end   
         xlim([30 43])
   xlabel('latitude'); ylabel({'Guild', 'MRS'});
%% Turnover
figure
mysubplot(1, 2, 0, 'Turnover')
name = 'turnover';    
    mysubplot(1,2,1)
    for m = 6:8
                ind = t_infoST(:,2) == m;   
            [Ydata, Xdata, dif] = betaNES_gradient(t_matST(ind,:), Tsite.decimallatitude, 2);
            Ydata = Ydata.sim(:) ;%./ dif(:);
                 Xdata = Xdata(:);
                
            script_fitpoly_latitude_trends         
    end
            xlim([30 43])
   xlabel('latitude'); ylabel({'Taxon', name});
 %%%%%%
 %  g_shannonST = D_ind_shannon(g_matST);
     mysubplot(1,2,2)
   for m = 6:8
                ind = g_infoST(:,2) == m;   
            [Ydata, Xdata, dif] = betaNES_gradient(g_matST(ind,:), Tsite.decimallatitude,2);
                Ydata = Ydata.sim(:) ;%./ dif(:);
                Xdata = Xdata(:);
               
            script_fitpoly_latitude_trends         
   end   
         xlim([30 43])
   xlabel('latitude'); ylabel({'Guild', name});
%% Nestedness
figure
mysubplot(1, 2, 0, 'Nestedness')
name = 'Nestedness';    
    mysubplot(1,2,1)
    for m = 6:8
                ind = t_infoST(:,2) == m;   
            [Ydata, Xdata, dif] = betaNES_gradient(t_matST(ind,:), Tsite.decimallatitude, 2);
            Ydata = Ydata.nes(:) ;%./ dif(:);
                 Xdata = Xdata(:);
                
            script_fitpoly_latitude_trends         
    end
            xlim([30 43]);ylim([0 0.4])
   xlabel('latitude'); ylabel({'Taxon', name});
 %%%%%%
 %  g_shannonST = D_ind_shannon(g_matST);
     mysubplot(1,2,2)
   for m = 6:8
                ind = g_infoST(:,2) == m;   
            [Ydata, Xdata, dif] = betaNES_gradient(g_matST(ind,:), Tsite.decimallatitude,2);
                Ydata = Ydata.nes(:) ;%./ dif(:);
                Xdata = Xdata(:);
               
            script_fitpoly_latitude_trends         
   end   
         xlim([30 43])
   xlabel('latitude'); ylabel({'Guild', name});