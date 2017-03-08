%% explore guild diversity  and test against null models
clear;clc
work_compile
   
 %% simulation of null model
 rng(1)
 it = 10000; %Elapsed time is 9318.111275 seconds for 10000 iteration with parfor
 nullrlat = zeros(1, it);
  nullplat = zeros(1, it);
   nullrmon = zeros(1, it);
  nullpmon = zeros(1, it);
  tic
 parfor i=1:it
    nullguild = datasample(guild2, length(guild2), 'Replace', false);
    [nullguildmat, guildlist] = Spp2Guild(bugdata, nullguild, [0]);
    [nullg_matST, g_infoST] = metacommunity( nullguildmat, sampledata(:, [1, 2] ) ) ;

[r, p] = f_mantel(squareform(pdist(log(nullg_matST+1))),  squareform(pdist(latitudeST )), 0, 10000);
[r2, p2] = f_mantel(squareform(pdist(log(nullg_matST+1))),  squareform(pdist(monthST)), 0, 10000);

 nullrlat(i) =r;  nullplat(i) =p;
  nullrmon(i) =r2;  nullpmon(i) =p2;
 end
 toc
save Mantel_null nullrlat nullrmon nullplat nullpmon
 %% Mantel test: latitude
 rng(1)
 figure
 [r,p] = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist([latitudeST ])), 0, 10000);
 mysubplot(1,2,1)
   histogram(nullrlat); hold on
        q1 = quantile(nullrlat, [ 0.5 0.95],2);
        vline(q1(1), 7, '--');   vline(q1(2), 7, ':'); 
        vline( r, 2);
        title('Mantel r')
 mysubplot(1,2,2)
   histogram(nullplat); hold on
        q1 = quantile(nullplat, [ 0.5 0.95],2);
        vline(q1(1), 7, '--');   vline(q1(2), 7, ':'); 
        vline( p, 2);
        title('Mantel p')
                 pctile_r =  (sum(nullrlat<r)+sum(nullrlat ==r)*0.5)/it;
          mysubplot(1,2,0,{['Mantel test with latitude (' num2str(it) ') randomization'], ['percentile = ' num2str(pctile_r)]})     

 %% Mantel test: month
 rng(1)
 figure
 [r2,p2] = f_mantel(squareform(pdist(log(g_matST+1))),  squareform(pdist(infoST(:,2))), 0, 10000);
 mysubplot(1,2,1)
   histogram(nullrmon); hold on
        q1 = quantile(nullrmon, [ 0.5 0.95],2)
        %vline(q1(1), 7, ':'); 
        vline(q1(1), 7, '--');   vline(q1(2), 7, ':'); 
        vline( r2, 2);
        title('Mantel r')
 mysubplot(1,2,2)
   histogram(nullpmon); hold on
        q1 = quantile(nullpmon, [ 0.5 0.95],2);
        vline(q1(1), 7, '--');   vline(q1(2), 7, ':'); 
        vline( p2, 2);
        title('Mantel p')  
                   pctile_r =  (sum(nullrmon<r2)+sum(nullrmon ==r2)*0.5)/it;
         mysubplot(1,2,0,{['Mantel test with monthe (' num2str(it) ') randomization'], ['percentile = ' num2str(pctile_r)]})     
