%% explore the *guildsums* data
clear;clc
work_compile2


%% NMDS plot 1
clmap = flipud(colormap('parula'));
bwmap = flipud( colormap('gray'));
    dist = squareform(pdist(t_LdataST));
% 2-D nonmetric Multidimensional Scaling:
    mds_1 = f_nmds(dist,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_1, num2cell(latitudeST), t_LdataST, [], 0, 'none',1);
    
 figure
[h1] =  plot_NMDS2(mds_1.scores, [],  siteinfo(g_infoST(:,1),2) ,[], bwmap);       
 figure
[h1] =  plot_NMDS2(mds_1.scores, [], num2month(t_infoST(:,2)) , [1.5 7 1]);       
    
%%  NMDS plot2
%% NMDS with the fathom toolbox
    disg = squareform(pdist(g_LdataST));
% 2-D nonmetric Multidimensional Scaling:
    mds_2 = f_nmds(disg,2,1,1);
    [h1, vec] = f_nmdsPlot(mds_2, num2cell(latitudeST), g_LdataST, guild2_names, 0, 'none',1);
%% for reference
figure
[h1] =  plot_NMDS2(mds_2.scores, vec, ...
                                   siteinfo(g_infoST(:,1),2),  [], flipud(colormap('parula')), ...
                                   guild2_names);
%%
clmap = flipud(colormap('parula'));
bwmap = flipud( colormap('gray'));

 figure 
 temp = guild2_names([1:7 9]); temp{1} = ' '; temp{2} = ' '; temp{7} = ' '; temp{6} = ' ';
 [h1] =  plot_NMDS2(mds_2.scores, vec([1:7 9],:), ...
                                   siteinfo(g_infoST(:,1),2),  [], bwmap(12:end,:), ...
                                   temp, 2);
            s = 1; mytext(vec(s,1), vec(s,2), guild2_names(s),14, 8) ;                   
            s = 2; mytext(vec(s,1), vec(s,2), guild2_names(s),14, 2) ;   
            s = 7; mytext(vec(s,1), vec(s,2), guild2_names(s),14, 9) ;     
            s = 6; mytext(vec(s,1), vec(s,2), guild2_names(s),14, 6) ; 
            myplot_square([-0.2 0.05], [ -0.2 0.05], 7); hold on
               ylabel(h1{3}, 'Latitude');
            xlabel('NMDS 1')
            ylabel('NMDS 2')
% Add and inset            
axes('Position',[.6 .6 .28 .28])
box off
 s = 8 ; myplot_vec(vec(s,1), vec(s,2), guild2_names(s),[], [], 1);
 s = 10 ; myplot_vec(vec(s,1), vec(s,2), guild2_names(s),[], [],1);
         axis([-0.2  0.05  -0.2  0.05])
            myplot_square([-0.2 0.05], [ -0.2 0.05], 7);
         hline(0, 7,':'); vline(0, 7,':');
%          
 figure
[h1] =  plot_NMDS2(mds_2.scores, [], num2month(g_infoST(:,2)) , [1.5 7 1]);         
%%







 