%% explore guild diversity  and test against null models
% using other indices
clear; clc
work_compile3

 %% simulation of null model
 rng(1)
 it = 1000; %Elapsed time is 9318.111275 seconds for 10000 iteration with parfor
 nullrlatMRS = zeros(1, it);    nullrmonMRS = zeros(1, it); nullmeanMRS = zeros(1, it);
 nullrlatSIM = zeros(1, it);    nullrmonSIM = zeros(1, it);  nullmeanSIM = zeros(1, it);
 nullrlatNES = zeros(1, it);    nullrmonNES = zeros(1, it);  nullmeanNES = zeros(1, it);
 %%
  tic
 parfor i = 1 : it
    % making null guilds 
        nullguild = datasample( Tguildtaxon.guildcode2, height(Tguildtaxon), 'Replace', false);
        [nullguildmat, guildlist] = Spp2Guild(wbugdata, nullguild, [0]);
        [nullg_matST, g_infoST] = metacommunity( nullguildmat, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;
    % calculate mean rank shift
        betaMSR = squareform(betaMRS_pairwise(nullg_matST) );
        nullmeanMRS(i) = mean(betaMSR(:));  
        nullrlatMRS(i) = f_mantel( betaMSR,  squareform(pdist(latitudeST)), 0, 1);
        nullrmonMRS(i) = f_mantel( betaMSR,  squareform(pdist(monthST)), 0, 1);
     % calculate simpson and nestedness
        betaNES = betaNES_pairwise(nullg_matST) ;
        nullmeanSIM(i) = mean(betaNES.psim);
        nullrlatSIM(i)  = f_mantel(squareform(betaNES.psim),  squareform(pdist(latitudeST )), 0, 1);
        nullrmonSIM(i)  = f_mantel(squareform(betaNES.psim),  squareform(pdist(monthST )), 0, 1);
        nullmeanNES(i) = mean(betaNES.pnes);
        nullrlatNES(i)  = f_mantel(squareform(betaNES.pnes),  squareform(pdist(latitudeST )), 0, 1);
        nullrmonNES(i)  = f_mantel(squareform(betaNES.pnes),  squareform(pdist(monthST )), 0, 1);
 end
 toc

%% 
  betaMSR = squareform(betaMRS_pairwise(g_matST) );
  mean(betaMSR(:))
  
  [r] = f_mantel( betaMSR,  squareform(pdist([latitudeST ])), 0, 1);
 betaNES = betaNES_pairwise(g_matST) ;
    mean(betaNES.psim)
     [r2] = f_mantel(squareform(betaNES.psim),  squareform(pdist([latitudeST ])), 0, 1);
    mean(betaNES.pnes)
     [r3] = f_mantel(squareform(betaNES.pnes),  squareform(pdist([latitudeST ])), 0, 1);