%% script used in work_Mantel_null_other_index.m

figure
  mysubplot(1,3,0, ['Guild-based community dissimilarity (', indexstr, ')'])
  mysubplot(1,3,1)
  p = pval(d,  nulld, 1, 1); 
  xlabel(['Mean ' indexstr])
 % ylim([0 ytop])
  title( ['p = ' num2str( p )] )
  mysubplot(1,3,2)
  p1 = pval(r,  nullr, 1,1); 
  xlabel('Spatial autocorrelation (r)')
  %  ylim([0 ytop])
  title( ['p = ' num2str( p1 )] )
  mysubplot(1,3,3)
  [p2,~, h] = pval(r2,  nullr2, 1,1); 
  xlabel('temporal autocorrelation (r)')
  title( ['p = ' num2str( p2 )] )
  %
 disp(['Latitudinal ', indexstr , ' (guild; permutation) :    ', pstring(p1) ])
 disp(['Temporal ', indexstr , ' (guild; permutation) :      ', pstring(p2) ])
  
  clear p1 p2 d r r2 nulld nullr nullr2 ytop