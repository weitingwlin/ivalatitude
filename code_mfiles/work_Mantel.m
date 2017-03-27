%% load data
clear;clc
work_compile3

 %% Mantel test

 [r, p] = f_mantel(squareform(pdist( g_LdataST)),  squareform(pdist(monthST)), 0, 10000);
 disp(['Temporal autocorrelation; Guild: r = ' num2str(r) '; p = ' num2str(p)])
 
 [r, p] = f_mantel(squareform(pdist( t_LdataST)),  squareform(pdist(monthST)), 0, 10000);
  disp(['Temporal autocorrelation; Taxon: r = ' num2str(r) '; p = ' num2str(p)])
 
 %%
  [r, p] = f_mantel(squareform(pdist( g_LdataST)),  squareform(pdist(  latitudeST)), 0, 10000);
  disp(['Spatial autocorrelation; Guild: r = ' num2str(r) '; p = ' num2str(p)])
  
 [r, p] = f_mantel(squareform(pdist( t_LdataST)),  squareform(pdist(  latitudeST)), 0, 10000);
   disp(['Spatial autocorrelation; Taxon: r = ' num2str(r) '; p = ' num2str(p)])
 