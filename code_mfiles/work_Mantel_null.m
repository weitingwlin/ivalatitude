%% explore guild diversity  and test against null models
clear;clc
work_compile3
   
 %% simulation of null model
 rng(1)
 it = 10000; %Elapsed time is 9318.111275 seconds for 10000 iteration with parfor
 nullrlat = zeros(1, it);
   nullrmon = zeros(1, it);
    nullrmean = zeros(1, it);
    
%%
  tic
 parfor i=1:it
     %  making pseudo-guild
        nullguild = datasample( Tguildtaxon.guildcode2, height(Tguildtaxon), 'Replace', false);
        [nullguildmat, guildlist] = Spp2Guild(vbugdata, nullguild, [0]);
        [nullg_matST, g_infoST] = metacommunity( nullguildmat, Tplant{:, {'Sitecode', 'Monthcode'}}) ;
        nullg_matST = nullg_matST(ind,: ); % t_infoST = t_infoST(ind,:);
     %  calculating dissimilarity
        diss = pdist(log(nullg_matST+1));
     % record mean and spatial, temporal autocorrelation
        nullrlat(i) = f_mantel(squareform(diss ),  squareform(pdist(latitudeST )), 0, 1);
        % no need iteration if we don't need p value from mantel test
        nullrmon(i) = f_mantel(squareform(diss ),  squareform(pdist(monthST)), 0, 1);
        nullrmean(i) = mean(diss );
 end
 toc
% save Mantel_null nullrlat nullrmon nullplat nullpmon
 
%%
  [r] = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist([latitudeST ])), 0, 1);
  nullr = nullrlat;
  r2 = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist(monthST)), 0, 1);
  nullr2 = nullrmon;
  d  = mean(pdist(log(g_matST+1)));
  nulld =  nullrmean;
indexstr = 'Euclidean';
  script_mantel_null_plot

