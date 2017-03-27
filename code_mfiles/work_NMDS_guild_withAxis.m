%% explore the *guildsums* data
clear;clc
work_compile3


%% NMDS plot 1
%clmap = flipud(colormap('parula'));
%bwmap = flipud( colormap('gray'));
 %   dist = squareform(pdist(t_LdataST));
% 2-D nonmetric Multidimensional Scaling:
 %   mds_1 = f_nmds(dist,2,1,1);
 %   [h1, vec] = f_nmdsPlot(mds_1, num2cell(latitudeST), t_LdataST, [], 0, 'none',1);
    
% figure 
%[h1] =  plot_NMDS2(mds_1.scores, [],   latitudeST ,[], bwmap);       
% figure
%[h1] =  plot_NMDS2(mds_1.scores, [], num2month(t_infoST(:,2)) , [1.5 7 1]);       
    
%%  NMDS plot2
%% NMDS with the fathom toolbox
    disg = squareform(pdist(g_LdataST));
% 2-D nonmetric Multidimensional Scaling:
    mds_2 = f_nmds(disg,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), g_LdataST, Tguildname{2:11,2}', 0, 'none',1);
%% for reference
figure
[h1] =  plot_NMDS2(mds_2.scores, vec, ...
                                  latitudeST,  [], flipud(colormap('parula')), ...
                                   Tguildname{2:11,2}');
%%
clmap = flipud(colormap('parula'));
bwmap = flipud( colormap('gray'));
guildname =Tguildname{2:11,2}';

 figure 
 temp = guildname([1:7 9]); temp{1} = ' '; temp{2} = ' '; temp{7} = ' '; temp{6} = ' ';
 [h1] =  plot_NMDS2(mds_2.scores, vec([1:7 9],:), ...
                                   latitudeST,  [], bwmap(12:end,:), ...
                                   temp, 2);
            s = 1; mytext(vec(s,1), vec(s,2), guildname(s),12, 8) ;                   
            s = 2; mytext(vec(s,1), vec(s,2), guildname(s),12, 2) ;   
            s = 7; mytext(vec(s,1), vec(s,2), guildname(s),12, 9) ;     
            s = 6; mytext(vec(s,1), vec(s,2), guildname(s),12, 6) ; 
            myplot_square([-0.2 0.05], [ -0.2 0.05], 7); hold on
               ylabel(h1{3}, 'Latitude', 'fontsize', 16);
          %  xlabel('NMDS 1')
          %  ylabel('NMDS 2')
% Add and inset            
axes('Position',[.6 .6 .28 .28])
box off
 s = 8 ; myplot_vec(vec(s,1), vec(s,2), guildname(s),[], [], 1);
 s = 10 ; myplot_vec(vec(s,1), vec(s,2), guildname(s),[], [],1);
         axis([-0.2  0.05  -0.2  0.05])
            myplot_square([-0.2 0.05], [ -0.2 0.05], 7);
         hline(0, 7,':'); vline(0, 7,':');         
%
figure
         [h1,y] =  plot_NMDS2(mds_2.scores, [], num2month(g_infoST(:,2)) , [1.5 17 7]);  hold on
%%          
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






 