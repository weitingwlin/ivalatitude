%% explore guild diversity  and test against null models
clear;clc
work_compile3
   
 %% simulation of null model
 rng(1)
 it = 1; %Elapsed time is 9318.111275 seconds for 10000 iteration with parfor
 nullrlat = zeros(1, it);
  nullplat = zeros(1, it);
   nullrmon = zeros(1, it);
  nullpmon = zeros(1, it);
  tic
 parfor i=1:it
    nullguild = datasample( Tguildtaxon.guildcode2, height(Tguildtaxon), 'Replace', false);
    [nullguildmat, guildlist] = Spp2Guild(wbugdata, nullguild, [0]);
    [nullg_matST, g_infoST] = metacommunity( nullguildmat, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;

 [r] = f_mantel(squareform(pdist(log(nullg_matST+1))),  squareform(pdist(latitudeST )), 0, 1);
 % no need iteration if we don't need p value from mantel test
 [r2] = f_mantel(squareform(pdist(log(nullg_matST+1))),  squareform(pdist(monthST)), 0, 1);


 nullrlat(i) =r; % nullplat(i) =p;
  nullrmon(i) =r2; % nullpmon(i) =p2;
 end
 toc
% save Mantel_null nullrlat nullrmon nullplat nullpmon
 
%% in one plot
 load Mantel_null 
 it = 10000;
 rng(1)
 
 figure
   % spatial autocorrelation
    mysubplot(1,2,1)
       % actual r
        [r] = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist([latitudeST ])), 0, 1);
       % pseudo guild (null model) r
        h = histogram(nullrlat, 20); hold on
        h.EdgeColor = 'w'; 
        q1 = quantile(nullrlat, [ 0.25 0.5 0.975],2);
        vline(q1(1), 7, ':');  v1 =  vline(q1(2), 7, '--');  v2 =   vline(q1(3), 7, ':'); % gray
        v3 = vline( r, 2); % red
           legend([v1,v2, v3], {'median', '95% CI', 'actual data'})
            pctile_r = (sum( nullrlat < r) + sum( nullrlat == r ) * 0.5) / it;
            pval = min(pctile_r, 1 - pctile_r);
        xlabel('r')
        title({'Spatial autocorrelation',  ['p = ' num2str(pval)]})
 mysubplot(1,2,2)
 [r2] = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist(t_infoST(:,2))), 0, 1);
   h = histogram(nullrmon, 20); hold on
      h.EdgeColor = 'w';
        q1 = quantile(nullrmon, [ 0.25 0.5 0.975],2)
              vline(q1(1), 7, ':');  v1 = vline(q1(2), 7, '--'); v2 = vline(q1(3), 7, ':'); % gray
        v3 = vline( r2, 2);
        legend([v1,v2, v3], {'median', '95% CI', 'actual data'})
          pctile_r =  (sum(nullrmon<r2)+sum(nullrmon ==r2)*0.5)/it;
            pval = min(pctile_r, 1 - pctile_r);
            xlabel('r')
        title({'Temporal autocorrelation', ['p = ' num2str(pctile_r)]})
  mysubplot(1,2,0,{ 'Mantel test for Guild-based communities', '(Euclidean)'})     