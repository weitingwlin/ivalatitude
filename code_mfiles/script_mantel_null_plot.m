%% script used in work_Mantel_null_other_index.m

figure
  mysubplot(1,3,0, ['Guild-based community dissimilarity (', indexstr, ')'])
  mysubplot(1,3,1)
  p = pval(d,  nulld, 1, 1); 
  xlabel(['Mean ' indexstr])
 % ylim([0 ytop])
  title( ['p = ' num2str( p )] )
  mysubplot(1,3,2)
  p = pval(r,  nullr, 1,1); 
  xlabel('Spatial autocorrelation (r)')
  %  ylim([0 ytop])
  title( ['p = ' num2str( p )] )
  mysubplot(1,3,3)
  [p,~, h] = pval(r2,  nullr2, 1,1); 
  xlabel('temporal autocorrelation (r)')
  title( ['p = ' num2str( p )] )
  %
  clear p d r r2 nulld nullr nullr2 ytop