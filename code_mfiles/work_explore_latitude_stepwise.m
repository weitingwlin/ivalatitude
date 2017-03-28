%%  **work\_explore\_latitude\_trend.m**
%% preparing data
    clear;clc
    work_compile3
   % mcolor = [12 37 8];
    mstyle = [1.5 17 7];
    latS = Tsite.decimallatitude;

%% problem with missing sample
% number of sample
    nsample = metacommunity(guildmat,Tplant{:, {'Sitecode', 'Monthcode'}} , 'count'); 
 %   ind_lesssample = find(nsample == 4);
   Xdata = Tsite.decimallatitude(t_infoST(nsample ~= 4,1));   
     mdata= t_infoST(nsample ~= 4,2);
%% richness
figure
   
    mysubplot(1, 5, 0, 'Richness')
    name = 'richness';    
    mysubplot(1,7,[2 3 ],'', [],0.1)
            richnessST = sum(  t_matST > 0, 2);    
            Ydata =  richnessST(nsample ~= 4);          
        script_fitpoly_latitude_stepwise         
            xlim([30 43])
            xlabel('latitude'); ylabel({'Taxon',name});
            title({['p =',  num2str(p,3)], model}, 'fontsize', 10);
%  guild richness
   mysubplot(1,7,[5 6],'', [], 0.1)
            g_richnessST = sum(  g_matST > 0, 2);
            Ydata =  g_richnessST(nsample ~= 4); 
        script_fitpoly_latitude_stepwise         
            xlim([30 43])
            xlabel('latitude'); ylabel({'Guild',name});
             title({['p =',  num2str(p,3)], model}, 'fontsize', 10);
%% diversity (Shannon)
figure
mysubplot(1, 5, 0, 'Shannon diversity')
 name = 'Shannon';    
    shannonST = D_ind_shannon(t_matST);
   % Xdata = Tsite.decimallatitude;   
    % plot by month
    mysubplot(1,7,[2 3],'', [], 0.1)
         Ydata = shannonST(nsample ~= 4);
           script_fitpoly_latitude_stepwise         
            xlim([30 43])
           
   xlabel('latitude'); ylabel({'Taxon', 'Shannon diversity'});
    title({['p =',  num2str(p,3)], model}, 'fontsize', 10);
   %%%%%%

      mysubplot(1,7,[5 6],'', [], 0.1)
         g_shannonST = D_ind_shannon(g_matST);
    Ydata =g_shannonST(nsample ~= 4);
  script_fitpoly_latitude_stepwise         
            xlim([30 43])

   xlabel('latitude'); ylabel({'Guild', 'Shannon diversity'});
    title({['p =',  num2str(p,3)], model}, 'fontsize', 10);
