
%% Things to do (do in a branch):
% 1.	Add as morpho-species: shouldn?t make much difference. 
% 2.    Add as guild, use original data (number of leaves as number of ind.)
% 3.    Rescale (zscore) for each guild; MRS will be hard to interpret
% 4.	Remove from Environment and check varpart
%% 0. prepare data
   clear;clc
   work_compile3
   gallminerST = metacommunity( Tplant{:,[11 12]}, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;
   plant6ST = plantST(:, 1:6); % remove galls and miners
   gallminerST = gallminerST(ind, :); % only include sites with 8 replicates, 
%% 1. Add as morpho-species
        % use number of leaves out of  30  as arbitury scale
        t_matST_gm = [t_matST,   gallminerST ];
        % log(n+1) transform
        t_LdataST_gm = log10(t_matST_gm + 1);
        
        %  the rest is basically **work\_NMDS\_taxon\_withAxis.m**
        
         % NMDS with the fathom toolbox
            disg = squareform(pdist(t_LdataST_gm));
        % 2-D nonmetric Multidimensional Scaling:
            mds_2 = f_nmds(disg,2,1,1);
            [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), t_LdataST_gm, [], 0, 'none',1);
              % (delete the graphs)
                 clmap = flipud(colormap('parula'));
                    bwmap = flipud( colormap('gray'));
            %
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
    % 
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
%% 2. Add as guild, use original data (number of leaves as number of ind.)
     % use number of leaves out of  30  as arbitury scale
        g_matST_gm = [g_matST,   gallminerST ];
        % log(n+1) transform
        g_LdataST_gm = log10(g_matST_gm + 1);
        
         Tguildname_gm = Tguildname{2:11,2}';
         Tguildname_gm{11} = 'Galls';
         Tguildname_gm{12} = 'Miners';
        %  the rest is basically **work\_NMDS\_taxon\_withAxis.m**
        
          disg = squareform(pdist(g_LdataST_gm));
    % 2-D nonmetric Multidimensional Scaling:
    mds_2 = f_nmds(disg,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), g_LdataST_gm, Tguildname_gm, 0, 'none',1);
    % for reference
figure
[h1] =  plot_NMDS2(mds_2.scores, vec, ...
                                  latitudeST,  [], flipud(colormap('parula')), ...
                                   Tguildname_gm);
                               
    % time
     figure
[h1,y] =  plot_NMDS2(mds_2.scores, [], num2month(g_infoST(:,2)) , [1.5 17 7]);  hold on
[ct, m]  = grpstats(y, monthST, {'mean', 'gname'});
m=1;
  myplot(ct(m,1), ct(m,2), 'S', 1, 8, 3);
for m = 2:3
    myplot(ct(m,1), ct(m,2), 'S', 1, 8, 3);
    dp =[ct(m, :) - ct(m-1, :)] * 0.8 ;
    quiver(ct(m-1, 1),ct(m-1, 2), dp(1), dp(2), 0,  'MaxHeadSize',0.9, 'color', 'k', 'linewidth', 1.5 );
end
% 
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
%% 3.    Rescale (zscore) for each guild; MRS will be hard to interpret
  
        g_LdataST_gm_z = zscore( log10(g_matST_gm + 1) );
        %
          disg = squareform(pdist(g_LdataST_gm_z));
    % 2-D nonmetric Multidimensional Scaling:
    mds_2 = f_nmds(disg,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), g_LdataST_gm_z, Tguildname_gm, 0, 'none',1);
   %% for reference
figure
[h1] =  plot_NMDS2(mds_2.scores, vec, ...
                                  latitudeST,  [], flipud(colormap('parula')), ...
                                   Tguildname_gm);
                               
    % time
     figure
[h1,y] =  plot_NMDS2(mds_2.scores, [], num2month(g_infoST(:,2)) , [1.5 17 7]);  hold on
[ct, m]  = grpstats(y, monthST, {'mean', 'gname'});
m=1;
  myplot(ct(m,1), ct(m,2), 'S', 1, 8, 3);
for m = 2:3
    myplot(ct(m,1), ct(m,2), 'S', 1, 8, 3);
    dp =[ct(m, :) - ct(m-1, :)] * 0.8 ;
    quiver(ct(m-1, 1),ct(m-1, 2), dp(1), dp(2), 0,  'MaxHeadSize',0.9, 'color', 'k', 'linewidth', 1.5 );
end
% 
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
        