%%  **work\_explore\_latitude\_trend.m**
%% preparing data
    clear;clc
    work_compile3
    mstyle = [1.5 17 7];
    tab = cell(4, 5);
 

%% problem with missing sample
% number of sample
    nsample = metacommunity(guildmat,Tplant{:, {'Sitecode', 'Monthcode'}} , 'count'); 
 %   ind_lesssample = find(nsample == 4);
   Xdata = Tsite.decimallatitude(t_infoST(nsample >= 7,1));   
     mdata= t_infoST(nsample >= 7, 2);
%% richness
figure
    mysubplot(1, 5, 0, 'Richness', 24)
% taxon richness
    index = 'Richness';    
    type = 'Taxon';
    mysubplot(1,7,[2 3 ],'', [],0.1)
            richnessST = sum(  t_matST > 0, 2);    
            Ydata =  richnessST(nsample  >= 7);          
            row = 1;
        script_fitpoly_latitude_stepwise         
        
%  guild richness
    type = 'Guild';
   mysubplot(1,7,[5 6],'', [], 0.1)
            g_richnessST = sum(  g_matST > 0, 2);
            Ydata =  g_richnessST(nsample  >= 7); 
            row = 2;
        script_fitpoly_latitude_stepwise         
      

%% diversity (Shannon)
figure
mysubplot(1, 5, 0, 'Shannon diversity', 24)
    index = 'Diversity';    
    type = 'Taxon';   
    shannonST = D_ind_shannon(t_matST);
    mysubplot(1,7,[2 3],'', [], 0.1)
           Ydata = shannonST(nsample  >= 7);
           row = 3;
           script_fitpoly_latitude_stepwise        
           
 %  ylabel({'Taxon', 'Shannon diversity'}, 'fontsize', 20);
  
   %%%%%%
        type = 'Guild';
      mysubplot(1,7,[5 6],'', [], 0.1)
         g_shannonST = D_ind_shannon(g_matST);
         Ydata =g_shannonST(nsample  >= 7);
         row = 4;
        script_fitpoly_latitude_stepwise         
    
      %  ylabel({'Guild', 'Shannon diversity'}, 'fontsize', 20);
%%
   tab = cell2table(tab, 'VariableNames', {'Type', 'Index',  'Model', 'adjRsquare', 'p'});
   writetable(tab, 'diversity.csv')
 