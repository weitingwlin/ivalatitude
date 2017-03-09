%% mean rank shift index
% 
% ref. Collins et al. (2008) Rank clocks and plant community dynamics.?Ecology, 89: 3534¡V3541
function [MRS, ref, dif] = mean_rank_shift(X, reference, degree)
[N, S] = size(X); % N site
                         % S species
if nargin <3
    degree = 1;
end                      
if nargin < 2
        reference = 1 : N;
end
%%
 MRS  = nan(N-1, degree);
 ref  = nan(N-1, degree);
 dif  = nan(N-1, degree);
% ordering sites base on information in `reference`
[y, I] = sort(reference);
ref(:, 1) = mean([y(1:N-1)'; y(2:N)'])';
X = X(I, :);
%%
for d = 1: degree
        for i = 1: N-d    
     %  ref(i) = mean(reference(i : i+1)); 
    % get rank for community 1
        [~ , ~, ic1] = unique(X(i,:));
        rank1 = max(ic1) - ic1' + 1; 
    % get rank for community 2
        [~ , ~, ic2] = unique(X(i+d,:)); 
        rank2 = max(ic2) - ic2' + 1;         
        RS = abs(rank1-rank2);
    % ignore the absent specie
        RS( any( X([i:1+1], :) == 0 )) = nan; 
        MRS(i, d) = nanmean(RS);
        ref(i,d) = mean([y(i)  y( i+ d)]);
        dif(i,d) = y(i + d) - y(i);
        end
end
%MRS = MRS ./ dif;