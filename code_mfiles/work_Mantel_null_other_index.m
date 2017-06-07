%% explore guild diversity  and test against null models
% using other indices
clear; clc
work_compile3

 %% simulation of null model
 rng(1)
 it = 10000; %Elapsed time is 9318.111275 seconds for 10000 iteration with parfor
 nullrlatEuc = zeros(1, it);    nullrmonEuc = zeros(1, it); nullmeanEuc = zeros(1, it);
 nullrlatMRS = zeros(1, it);    nullrmonMRS = zeros(1, it); nullmeanMRS = zeros(1, it);
 nullrlatSIM = zeros(1, it);    nullrmonSIM = zeros(1, it);  nullmeanSIM = zeros(1, it);
 nullrlatNES = zeros(1, it);    nullrmonNES = zeros(1, it);  nullmeanNES = zeros(1, it);
 nullrlatSOR = zeros(1, it);    nullrmonSOR = zeros(1, it);  nullmeanSOR = zeros(1, it);
 %%
  tic
 parfor i = 1 : it
    % making null guilds 
        nullguild = datasample( Tguildtaxon.guildcode2, height(Tguildtaxon), 'Replace', false);
        [nullguildmat, guildlist] = Spp2Guild(vbugdata, nullguild, [0]);
        [nullg_matST, g_infoST] = metacommunity( nullguildmat, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;
    % Euclidean
             diss = pdist(log(nullg_matST+1));
        nullrlatEuc(i) = f_mantel(squareform(diss ),  squareform(pdist(latitudeST )), 0, 1);
        nullrmonEuc(i) = f_mantel(squareform(diss ),  squareform(pdist(monthST)), 0, 1);
        nullmeanEuc(i) = mean(diss );
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
        nullmeanSOR(i) = mean(betaNES.psor);
        nullrlatSOR(i)  = f_mantel(squareform(betaNES.psor),  squareform(pdist(latitudeST )), 0, 1);
        nullrmonSOR(i)  = f_mantel(squareform(betaNES.psor),  squareform(pdist(monthST )), 0, 1);
 end
 toc
%% Euclidean
indexstr = 'Euclidean';
  [r] = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist([latitudeST ])), 0, 1);
  nullr = nullrlatEuc;
  r2 = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist(monthST)), 0, 1);
  nullr2 = nullrmonEuc;
  d  = mean(pdist(log(g_matST+1)));
  nulld =  nullmeanEuc;
  
    script_mantel_null_plot
%% inference MSR
  betaMSR = squareform(betaMRS_pairwise(g_matST) );
        d = mean(betaMSR(:));
        nulld = nullmeanMRS;
        r = f_mantel( betaMSR,  squareform(pdist(latitudeST )), 0, 1);
        nullr = nullrlatMRS;
        r2 = f_mantel( betaMSR,  squareform(pdist(monthST )), 0, 1);
        nullr2 = nullrmonMRS;
    %  disp( ['mean (MRS), p = ' num2str( pval(meand,  nullmeanMRS) )])
    %  disp( ['spatial-autocorrelation (MRS), p = ' num2str( pval(r,  nullrlatMRS) )])
    %  disp( ['temporal-autocorrelation (MRS), p = ' num2str( pval(r2,  nullrmonMRS) )])
% plot  
  indexstr = 'MRS';
  %  ytop = 2000
  script_mantel_null_plot
  
%%   
 betaNES = betaNES_pairwise(g_matST) ;
    d = mean(betaNES.psim);
    nulld =  nullmeanSIM;
     r = f_mantel(squareform(betaNES.psim),  squareform(pdist([latitudeST ])), 0, 1);
     nullr =  nullrlatSIM;
     r2 = f_mantel(squareform(betaNES.psim),  squareform(pdist([monthST ])), 0, 1);
     nullr2 =  nullrmonSIM;
% disp( ['mean (SIM), p = ' num2str( pval(meand,  nullmeanSIM) )])
%[~, pctile] =  pval(meand,  nullmeanSIM) 
% disp( ['spatial-autocorrelation (SIM), p = ' num2str( pval(r,  nullrlatSIM) )])
% disp( ['temporal-autocorrelation (SIM), p = ' num2str( pval(r2,  nullrmonSIM) )])
% plot  
  indexstr = 'Simpson';
 % ytop = 2500;
  script_mantel_null_plot
%%
     d = mean(betaNES.pnes);
     nulld =  nullmeanNES;
     r = f_mantel(squareform(betaNES.pnes),  squareform(pdist([latitudeST ])), 0, 1);
     nullr =  nullrlatNES;
     r2= f_mantel(squareform(betaNES.pnes),  squareform(pdist([monthST ])), 0, 1);
     nullr2 =  nullrmonNES;
  %   disp( ['mean (NES), p = ' num2str( pval(meand,  nullmeanNES) )])
  %  disp( ['spatial-autocorrelation (NES), p = ' num2str( pval(r,  nullrlatNES) )])
  %  disp( ['temporal-autocorrelation (NES), p = ' num2str( pval(r2,  nullrmonNES) )])
  % plot  
  indexstr = 'Nestness';
  %ytop = 2500
  script_mantel_null_plot
%% Sorenson
     d = mean(betaNES.psor);
     nulld =  nullmeanSOR;
     r = f_mantel(squareform(betaNES.psor),  squareform(pdist([latitudeST ])), 0, 1);
     nullr =  nullrlatSOR;
     r2= f_mantel(squareform(betaNES.psor),  squareform(pdist([monthST ])), 0, 1);
     nullr2 =  nullrmonSOR;
  %   disp( ['mean (NES), p = ' num2str( pval(meand,  nullmeanNES) )])
  %  disp( ['spatial-autocorrelation (NES), p = ' num2str( pval(r,  nullrlatNES) )])
  %  disp( ['temporal-autocorrelation (NES), p = ' num2str( pval(r2,  nullrmonNES) )])
  % plot  
  indexstr = 'Sorenson';
  %ytop = 2500
  script_mantel_null_plot