%% script for plotting
    clear;clc
    work_compile3
% script_guild_latitude_PCA
% called in work_explore_guild_latitude.m
%%
[coeff, score,latent] = pca(g_LdataST);
[n,p]= size(g_LdataST);
%% *Plot of the first 4 PCs:*
pcprint = 2
figure
mysubplot(7,1,1:3)
for j=1:pcprint
h = myplot(1:p, coeff(:, j), 'L', j, j); hold on
end
hline
legend('PC 1','PC 2');
title('Composition of each PC')
xticks([1:p]);
xticklabels(Tguildname{2:end, 2});
set(gca,'XTickLabelRotation',-45)
xlabel('variable (guild)'); ylabel('PC coefficient')
axis tight

% *The percentage of varience explained by each PC* 
%figure
mysubplot(8,1,7:8)
varPC=latent./sum(latent);
myplot(1:p,cumsum(varPC),'L')
axis([1 p 0 1.01])
title('Cumulative % of variance explained by PC')
xlabel('PC'); ylabel('% of variance')
%%
figure
 % myplot(score(:,1),score(:,2),'S',8)
  % S means scatter plot; 8 is for light blue
   for i=1:n
       scatter(score(i,1), score(i,2), 40 , latitudeST(i), 'filled')   ; hold on            
   text(score(i,1),score(i,2),num2str(t_infoST(i, 2)),'fontsize',8)
   end
   xlabel(['PC1   (' num2str(varPC(1)*100) '% varience)'])
   ylabel(['PC2   (' num2str(varPC(2)*100) '% varience)'])
   set(gca,'FontSize',14,'linewidth',2);
   colormap(flipud(colormap('parula'))); 
   colorbar;
