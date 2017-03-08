% Species abundance distribution
    clear;clc
    work_compile2
   % taxonguild2 = load('./data/taxonguild2.txt');
   taxonguild2 = zeros(size(taxonlist));
   for i = 1:99
       ind= find(taxon2==taxonlist(i));
        taxonguild2(i) = guild2( ind(1) );
   end

%% For each site, guild composition rather constant over time?
[Y,I] = sort(siteinfo(:, 2), 'descend'); % I is the sorted patch id from north to south
mstr={'June', 'July', 'August'}

for s = 1:15
    S = I(s); % site ID
    ind = (g_infoST(:,1)==S);
    sub =log( g_matST(ind,:) +1);
    sitestr =['site: ' num2str(S) ' (lat.: ' num2str(siteinfo(S,2)) ')'];
     myplot_RAC2(sub, guild2_names, mstr, sitestr, [], [], 1, [2 6]);  
end
%% another way to print it
 [Y,I2] = sort(siteinfo(:, 2)); % small to large
lat = siteinfo(I2, 2);

 g_matST(ind, :);
for m = 6:8
        ind = (g_infoST(:, 2) == m);
        sub1 = g_matST(ind, :);
        sub2 = sub1(I2,:);
        myplot_RAC2(sub2, guild2_names, num2str(I2), num2month(m), [], [], 1);                 
end

%% But species composition change within guild?
g=6; 
gname = guild2_names(g) ;
    inguild=t_matST(:, taxonguild2==g);
s=9;
     S = I(s); % site ID
    ind = (g_infoST(:,1)==S);
    sub =log( inguild(ind,:) +1);
    sitestr =['site: ' num2str(S) ' (lat.: ' num2str(siteinfo(S,2)) '); ' gname{1} ];
   %  myplot_RAC(sub, 'taxon', mstr, sitestr, [], [], 1);  
      myplot_RAC2(sub, 'taxon', mstr, sitestr, [], [], 1,[9 1]);  
    %     myplot_RAC2(sub, 'taxon', mstr, sitestr, [], [], 0);  
%% for each time, guild composition change over latitude?
   
%% How about trophic level?
    [Y,I2] = sort(siteinfo(:, 2)); % small to large
lat = siteinfo(I2, 2);
for m = 6:8
     ind = (g_infoST(:, 2) == m);
     sub1 = g_matST(ind, :);
            sub2 = sub1(I2, :);
            sub2H = sum( sub2(:, 1:3), 2);
            sub2P = sum( sub2(:, 4:7), 2);
      mysubplot(3, 3, [(m-5) (m-2)],'', 0.2,0.2)      
            myplot(lat, sub2H, 'S', 3.5); hold on      
            myplot(lat, sub2P, 'S', 2, 's');
                if m==6
                    ylabel('Population')
                end
                ylim([ 0 700]); xlim([30 45])
                legend('Herbivores', 'Predators')
                title(num2month(m))
                set(gca, 'Xtick', [])
      mysubplot(3, 3, m+1,'', 0.2,0.2 )
            myplot(lat, sub2P./sub2H, 'S', 1); hold on
                ylim([0 2.5]); xlim([30 45])
                hline(1)
                xlabel('Latitude')
                if m==6
                    ylabel('Predator: Herbivore')     
                end
end

%% Guild swapping within trophic level?
 [Y,I2] = sort(siteinfo(:, 2)); % I is the sorted patch id from north to south
    sstr = cell(size(15));
    for s = 1:15
            sstr{s} = ['site:' num2str(I2(s)) ' (' num2str(siteinfo(I2(s),2)) ')'];
    end
% 
    for m = 6:8
            ind = (g_infoST(:,2)==m);
                sub1 = g_matST(ind,:);
            sub2 = sub1(I2,:); % now ranked from high to low latitude 
            sub2H = sub2(:, 1:3);
            sub2P = sub2(:, 4:7);
            for z = 1:3
                    indz = (z-1)*5 + [1:5];       
                    myplot_RAC(sub2H(indz,:), guild2_names(1:3), sstr(indz), [num2month(m) ' (Herbivores)'], [], [], 1);
                     %myplot_RAC(sub2P(indz,:), guild2_names(4:7), sstr(indz), [num2month(m) ' (Predators)'], [6 7 8 9], {'^','p','>','<'}, 1);
            end
    end

%% Taxon swapping within
 [Y,I2] = sort(siteinfo(:, 2)); % I is the sorted patch id from north to south
    sstr = cell(size(15));
    for s = 1:15
            sstr{s} = ['site:' num2str(I2(s)) ' (' num2str(siteinfo(I2(s),2)) ')'];
    end
    
    g=4
          inguild=t_matST(:, taxonguild2==g);
      for m = 6:8
            ind = (g_infoST(:,2)==m);
        
                sub1 = g_matST(ind,:);
            sub2 = sub1(I2,:); % now ranked from high to low latitude 
            sub2H = sub2(:, 1:3);
            sub2P = sub2(:, 4:7);
            for z = 1:3
                    indz = (z-1)*5 + [1:5];       
                    myplot_RAC(sub2H(indz,:), guild2_names(1:3), sstr(indz), [num2month(m) ' (Herbivores)'], [], [], 1);
                     %myplot_RAC(sub2P(indz,:), guild2_names(4:7), sstr(indz), [num2month(m) ' (Predators)'], [6 7 8 9], {'^','p','>','<'}, 1);
            end
      end
    
g=4; 
gname = guild2_names(g) ;
    inguild=t_matST(:, taxonguild2==g);
s=7;
     S = I(s); % site ID
    ind = (g_infoST(:,1)==S);
    sub = inguild(ind,:);
    sitestr =['site: ' num2str(S) ' (lat.: ' num2str(siteinfo(S,2)) '); ' gname{1} ];
     myplot_RAC(sub, 'taxon', mstr, sitestr, [], [], 1);  
    