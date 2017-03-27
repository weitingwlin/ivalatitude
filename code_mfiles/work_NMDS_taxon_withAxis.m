%% explore the *guildsums* data
clear;clc
work_compile3

%% NMDS with the fathom toolbox
    disg = squareform(pdist(t_LdataST));
% 2-D nonmetric Multidimensional Scaling:
    mds_2 = f_nmds(disg,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), t_LdataST, [], 0, 'none',1);
%% for reference
figure
[h1] =  plot_NMDS2(mds_2.scores, [], ...
                                  latitudeST,  [], flipud(colormap('parula')));
%%
clmap = flipud(colormap('parula'));
bwmap = flipud( colormap('gray'));

%%          
 figure
    [h1,y] =  plot_NMDS2(mds_2.scores, [], num2month(t_infoST(:,2)) , [1.5 17 7]);  hold on
    [ct, m]  = grpstats(y, monthST, {'mean', 'gname'});
m=1;
  myplot(ct(m,1), ct(m,2), 'S', 1, 8, 3);
for m = 2:3
    myplot(ct(m,1), ct(m,2), 'S', 1, 8, 3);
    dp =[ct(m, :) - ct(m-1, :)] * 0.8 ;
    quiver(ct(m-1, 1),ct(m-1, 2), dp(1), dp(2), 0,  'MaxHeadSize',0.9, 'color', 'k', 'linewidth', 1.5 );
end
%% 
figure
[h1,y] =  plot_NMDS2(mds_2.scores, [],   latitudeST , [], bwmap(12:end,:));  hold on
[ct, l]  = grpstats(y, latitudeST, {'mean', 'gname'});
l=1;
  myplot(ct(l,1), ct(l,2), 'S', 1, 8, 2);
for l = 2:15
    myplot(ct(l,1), ct(l,2), 'S', 1, 8, 2);
    dp =[ct(l, :) - ct(l-1, :)] * 0.95 ;
    quiver(ct(l-1, 1),ct(l-1, 2), dp(1), dp(2), 0,  'MaxHeadSize',0.4, 'color', 'k', 'linewidth', 1.5 );
end
     ylabel(h1{3}, 'Latitude', 'fontsize', 16);






 