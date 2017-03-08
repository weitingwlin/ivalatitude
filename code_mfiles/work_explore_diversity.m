%% preparing data
    clear;clc
    work_compile3
    
%% plant scale diversity
region = {'H', 'M', 'L'}
t_rich_p = sum((taxonmat > 0),2); % taxon richness at plant scale
t_rich_s = sum(t_matST > 0, 2); % taxon richness at site scale
% latitude_p = siteinfo(sampledata(:,1),2); % latitude of each plant
latitude_p = Tplant.latitude;
% month_p = sampledata(:,2); % month of each plant
month_p = Tplant.Monthcode
for m = 1:3
    figure
    N = 8; % rarefaction sample size
    it = 100; % resampling iteration  
     for r = 1:3
        siteind = siteinfo(siteinfo(:,3) == r, 1);
        temp= any((repmat(siteind',339,1) - repmat(sampledata(:,1), 1, 5))==0, 2); % region index
        ind = all([temp , sampledata(:,2) == month(m)] , 2 );
        pool = taxonmat(ind,:); % regional species pool for the month
        [adjgamma, CI, gamma] = rarefaction(pool, N,  it);
        myplot(siteinfo(siteind,2), repmat(gamma, 5,1), 'L', m+11); hold on
        myplot(sort(siteinfo(siteind,2)), repmat(adjgamma, 5,1), 'L', m+11, 2);
    end
    for s = 1:15
        ind = find(all([month_p ==month(m),  sampledata(:,1) ==s ], 2));
        myplot(latitude_p(ind)+(m*0.05), t_rich_p(ind), 'S', m + 11.5, m); hold on  
        ind2 = find(all([t_infoST(:,2) ==month(m),  t_infoST(:,1) ==s ], 2));       
        myplot(latitude_p(ind(1))-0.05, t_rich_s(ind2), 'S', m+11, m);
    end
        title(num2month(month(m)))
        box off
        ylim([1 99])
        xlabel('latitude')
     ylabel('Taxon richness')
end
%%
figure
for s = 1:15
    ind = t_infoST(:,1)==s;
    rich = sum(sum(t_matST(ind,:)) > 0);
    myplot(siteinfo(s, 2), rich, 'S', 1); hold on
end
    N = 24; % rarefaction sample size
    it = 10000; % resampling iteration
for r = 1:3
        siteind = siteinfo(siteinfo(:,3)==r, 1);
        ind = any((repmat(siteind',339,1) - repmat(sampledata(:,1), 1, 5)) ==0, 2);
        pool = taxonmat(ind,:);
        [adjgamma, CI, gamma] = rarefaction(pool, N,  it);
        myplot(siteinfo(siteind,2), repmat(gamma, 5,1), 'L', 1); hold on
        myplot(sort(siteinfo(siteind,2)), repmat(adjgamma, 5,1), 'L', 1, 2);
end
   [adjeps,  CI, eps] = rarefaction( taxonmat, 120,  it);
   myplot(siteinfo(:,2), repmat(eps, 15,1), 'L', 1); hold on
   myplot(sort(siteinfo(:,2)), repmat(adjeps, 15,1), 'L', 1, 2);
      ylim([1 99])
     title('Summer (sum of 3 monthes)')
    xlabel('latitude')
    ylabel('Taxon richness')