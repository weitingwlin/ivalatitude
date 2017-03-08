%% explore plant data
%  `work_explore_plant.m`
clear;clc
work_compile

 plantdata = Tplant{:,[5,6,8,11,12, 17,18, 19]};
 plantdatanames = tnames(Tplant(:,[5,6,8,11,12, 17,18, 19]))
 %%
 figure
 mysubplot(3,3, 0, 'qqplot  of the original data', 0.4)
 for i = 1:8
     mysubplot(3, 3, i+1, '', 0.4)
   %  histogram(plantdata(:,i));
     qqplot(plantdata(:,i));
     title(plantdatanames(i));
 end
 %%
   Lplant = plantdata; 
   % Lplant(:,[1 2 4 5 6 7]) = log(plantdata(:,[ 1 2 4 5  6 7 ])+1);
   Lplant(:,[1 2 6 7 8]) = log(plantdata(:,[ 1 2  6 7 8])+1);
   Lplant(:, [4 5]) = asin(sqrt(Lplant(:, [4 5])./30));
   figure
    mysubplot(3,3, 0, 'qqplot  of the transformed data', 0.4)
   for i = 1:8
     mysubplot(3, 3, i+1, '', 0.4)
     %histogram(Lplant(:,i));
     qqplot(Lplant(:,i))
     title(plantdatanames(i));
 end
 %%
% [matST, infoST] = metacommunity( taxasums, sampledata(:, [1, 2] ) ) ;
[LplantST, infoST] = metacommunity( Lplant, sampledata(:, [1, 2] ), 'mean' ) ;
%% 
figure
mysubplot(1,9,1:4, [], [], 0.5)
      [Y, stress, disparities, h] = plot_NMDS(LplantST, num2month(infoST(:,2)) );
      title('Time color-coded');
mysubplot(1, 9, 5:9, [], [], 0.5)
      [Y, stress, disparities, h] = plot_NMDS(LplantST, siteinfo(infoST(:,1),2), flipud(colormap('parula')));
      ylabel(h{2}, 'Latitude')
     title('Latitude color-coded');
mysubplot(1, 2, 0, {'Taxon-based communities'; ['NMDS, stress = ' num2str(stress)]})
%%
[coeff, score, latent] = pca( nanzscore(Lplant) );
   myplot(1:length(latent), cumsum(latent)./sum(latent), 'B');
   xlabel('PC'); ylabel('% of variance explained')
coeffPC1 = coeff(:, 1); % coefficient of PC1
PC1 = score(:,1);
%% Latitudinal gradient of plant area
     mysubplot(3, 3, 0, {'Latitudinal pattern of plant variables', 'transformed data'})
for i = 1 : 8 % variables
        thingname = plantdatanames(i);
        mysubplot(3, 3, i+1)
        for m=6:8
            ind = Tplant{:,2} == m;
            myplot(Tplant.latitude(ind)+0.1*(m-6), Lplant(ind, i), 'S', m+6 ); hold on
        end
        ylabel(thingname); xlabel('latitude');
end
         legend('June', 'July', 'August')