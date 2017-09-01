%% preparing data
% explore stability and synchrony, based on Bulleri et al. 2012
    clear;clc
    work_compile3
%% problem with missing sample
% number of sample
    nsample = metacommunity(guildmat,Tplant{:, {'Sitecode', 'Monthcode'}} , 'count'); 
 %   ind_lesssample = find(nsample == 4);
   Xdata = Tsite.decimallatitude(t_infoST(nsample >= 7,1));   % latitude
   latIn = accumarray(t_infoST(nsample >= 7,1), t_infoST(nsample >= 7,1), [], @numel) == 3;
   Ydata = t_matST(nsample >= 7, :);
%% temporal stability in overall abundance (density)
   meanS = accumarray(t_infoST(nsample >= 7,1), sum(Ydata, 2), [], @mean);
   stdS = accumarray(t_infoST(nsample >= 7,1), sum(Ydata, 2), [], @std);

    figure
    mysubplot(3, 1, 0, 'Temporal stability in total abundance')
    mysubplot(3, 1, 1)
    myplot(Tsite.decimallatitude(latIn), meanS(latIn)); 
    ylabel({'mean abundance',' (\mu)'})
    mysubplot(3, 1, 2)
    myplot(Tsite.decimallatitude(latIn), stdS(latIn));
     ylabel('STD (\sigma)')
    mysubplot(3, 1, 3)
    myplot(Tsite.decimallatitude(latIn),  meanS(latIn) ./ stdS(latIn));
    ylabel({'Temporal stability', '(\mu / \sigma)'})
    xlabel('Latitude')
%% synchrony


