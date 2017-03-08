% function that calculated expected richness if sample were smaller
%
%  [richness,  speciespool] = rarefaction(mat, N, it)
%
%  mat: n * p matrix for n sites p species
%  N: sample size
%  it: iteration

function [richness, CI, speciespool, shannon] = rarefaction(mat, N, it)
[n,p]= size(mat);
shannon = [];
rarefaction = zeros(it,1);
shannonit = zeros(it,1);
for i = 1:it
    sub = randperm(n, N); %
    rarefaction(i) = sum(sum(mat(sub, :)) > 0);
    shannonit(i) = D_ind_shannon(sum(mat(sub, :)));
end
speciespool = sum(sum(mat) > 0);
shannon.pool = D_ind_shannon(sum(mat));
shannon.CI = quantile(shannonit, [0.025 0.975])
CI = quantile(rarefaction, [0.025 0.975]);
richness = mean(rarefaction);
shannon.rare = mean(shannonit);
end
%%
