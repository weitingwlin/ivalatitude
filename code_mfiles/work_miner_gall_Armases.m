
%% Things to do (do in a branch):
% 1.	Add as morpho-species: shouldn?t make much difference. 
% 2.    Add as guild, use original data (number of leaves as number of ind.)
% 3.    Rescale (zscore) for each guild; MRS will be hard to interpret
% 4.	Remove from Environment and check varpart
%% 0. prepare data
   clear;clc
   work_setup
   work_compile3
   AgmST = metacommunity( Tplant{:,[6 11 12]}, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;
   % Armases, gall, miner
   plant3ST = plantST(:, [ 1 3 4 5 6 ]); % remove Armases, galls and miners
   AgmST = AgmST(ind, :); % only include sites with 8 replicates, 
%% 1. Add as morpho-species
        % use number of leaves out of  30  rescaled
        % log(n+1) transform
       % t_LdataST = log10(t_matST + 1);
        LAgmST = [log10(AgmST(:, 1) + 1)  asin(sqrt(AgmST(:, [2 3]) ./ 240))];
        % rescale the transformed data
          t_LdataST_rs = ( t_LdataST - mean(t_LdataST(:)) ) ./  std(t_LdataST(:));
          LAgmST_rs = (LAgmST - repmat((mean(LAgmST)), 40, 1))  ./  repmat((std(LAgmST)), 40, 1);
        %  combine
         t_LdataST_Agm_rs =  [ t_LdataST_rs   LAgmST_rs] ;
         clear t_LdataST_rs  LAgmST  AgmST   LAgmST
        %  the rest is basically **work\_NMDS\_taxon\_withAxis.m**
%%         
         % NMDS with the fathom toolbox
            disg = squareform(pdist(t_LdataST_Agm_rs));
        % 2-D nonmetric Multidimensional Scaling:
            mds_2 = f_nmds(disg,2,1,1);
            [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), t_LdataST_Agm_rs, [], 0, 'none',1);
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
      %  g_matST_gm = [g_matST,   gallminerST ];
        % log(n+1) transform
        % g_LdataST = log10(g_matST + 1);
         % rescale the transformed data
          g_LdataST_rs = ( g_LdataST - mean(g_LdataST(:)) ) ./  std(g_LdataST(:));
  
        %  combine
         g_LdataST_Agm_rs =  [ g_LdataST_rs   LAgmST_rs] ;
         
         Tguildname_Agm = Tguildname{2:11,2}';
         Tguildname_Agm{11} = 'Armases';
         Tguildname_Agm{12} = 'Galls';
         Tguildname_Agm{13} = 'Miners';
         clear g_LdataST_rs LAgmST_rs
%%
%  the rest is basically **work\_NMDS\_taxon\_withAxis.m**
        
          disg = squareform(pdist(g_LdataST_Agm_rs));
    % 2-D nonmetric Multidimensional Scaling:
    mds_2 = f_nmds(disg,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), g_LdataST_Agm_rs, Tguildname_Agm, 0, 'none',1);

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
%% 
figure
[h1] =  plot_NMDS2(mds_2.scores, vec, ...
                                  latitudeST,  [], flipud(colormap('parula')), ...
                                   num2cellstr(1:13));
                               
Tguildname_Agm
     %% latitude, axis
 figure 
 temp = Tguildname_Agm; 
 temp{10} = ' ';  temp{2} = ' ';temp{9} = ' ';  temp{6} = ' ';
% temp{7} = ' '; temp{8} = ' '; 
 %
 [h1] =  plot_NMDS2(mds_2.scores, vec([1:13],:), ...
                                   latitudeST,  [], bwmap(12:end,:), ...
                                   temp, 2);
            s = 2; mytext(vec(s,1), vec(s,2), Tguildname_Agm{s},12, 2) ;                   
          %  s = 5; mytext(vec(s,1), vec(s,2),  Tguildname_Agm{s} ,12, 8) ;   
            s = 6; mytext(vec(s,1), vec(s,2),  Tguildname_Agm{s}, 12, 1) ;     
            s = 9; mytext(vec(s,1), vec(s,2),  Tguildname_Agm{s},12, 7) ; 
           
s = 10; vec(s,:)
          %  xlabel('NMDS 1')
          %  ylabel('NMDS 2')
% Add and inset            
% myplot_square([-0.2 0.15], [ -0.15 0.10], 7); hold on
%axes('Position',[0.20  0.16 .315 .225]);
%box off
%  axis([-0.2 0.15  -0.15 0.10] )
 %           myplot_square([-0.2 0.15], [  -0.15 0.10], 7);
            
 %  hline(0, 7,':'); hold on
%   vline(0, 7,':'); 
% s = 7 ; myplot_vec(vec(s,1), vec(s,2), '',[], [], []); 
%           mytext(vec(s,1), vec(s,2), [ '\n  ' Tguildname_Agm{s}], 12, 5) ;    
% s = 8 ; myplot_vec(vec(s,1), vec(s,2), '',2, [], []); 
%            mytext(vec(s,1), vec(s,2), [ '   ' Tguildname_Agm{s}], 12, 1) ;  
% s = 5 ; myplot_vec(vec(s,1), vec(s,2), '',[], [],[]);
%            mytext(vec(s,1), vec(s,2)+0.02, [  '         ' Tguildname_Agm{s}], 12, 2) ;    
% s = 3 ; myplot_vec(vec(s,1), vec(s,2), '',[], [],[]);
%            mytext(vec(s,1), vec(s,2), [Tguildname_Agm{s} ], 12, 7) ;   
% s = 10 ; myplot_vec(vec(s,1), vec(s,2), '',[], [], 5);
            %mytext(vec(s,1), vec(s,2), [Tguildname_Agm{s} '\n   \n '], 12, 3) ;  
 %  axis([-0.2 0.15  -0.15 0.10] )            
        