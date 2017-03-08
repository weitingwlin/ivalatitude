%% explore the *guildsums* data
clear;clc
work_compile2


%% NMDS plot 1
figure
mysubplot(1,9,1:4, [], [], 0.5)

      [Y, stress, disparities, h] = plot_NMDS(t_LdataST, num2month(t_infoST(:,2)) );
      title('Time color-coded');
mysubplot(1, 9, 5:9, [], [], 0.5)
      [Y, stress, disparities, h] = plot_NMDS(t_LdataST, siteinfo(t_infoST(:,1),2), flipud(colormap('parula')));
      ylabel(h{2}, 'Latitude')
     title('Latitude color-coded');
mysubplot(1, 2, 0, {'Taxon-based communities'; ['NMDS, stress = ' num2str(stress)]})
%%  NMDS plot2

figure
mysubplot(1,9,1:4, [], [], 0.5)
      [Y, stress, disparities] = plot_NMDS(g_LdataST, num2month(g_infoST(:,2)) );
        title('Time color-coded');
 mysubplot(1, 9, 5:9, [], [], 0.5)         
      [Y, stress, disparities, h] = plot_NMDS(g_LdataST, siteinfo(g_infoST(:,1),2), flipud(colormap('parula')));
           ylabel(h{2}, 'Latitude')
         title('Latitude color-coded');
 mysubplot(1, 2, 0, {'Guild-based communities'; ['NMDS, stress = ' num2str(stress)]})
 
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
 