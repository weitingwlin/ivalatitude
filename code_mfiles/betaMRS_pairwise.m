% pairwise community dissimilarity using mean rank shift as index
function [MRS] = betaMRS_pairwise(matin)

[ N, P ] = size(matin);

MRS = zeros(N);

for i = 1 : (N-1)
        for j = (i + 1) : N % this is how you get all unique paires
                % get rank for community 1
                [~ , ~, ic1] = unique(matin(i,:));
                rank1 = max(ic1) - ic1' + 1; 
                % get rank for community 2
                [~ , ~, ic2] = unique(matin(j,:)); 
                rank2 = max(ic2) - ic2' + 1;         
                RS = abs(rank1-rank2);
                % ignore the absent specie
                RS( any( matin([i, j], :) == 0 )) = nan; 
                MRS(i, j) = nanmean(RS);
                MRS(j, i) = nanmean(RS);
        end
end
%% 
MRS =  squareform(MRS);