%% betaNES: turnover vs. nestedness
% 
% 
function [ind, ref, dif] = betaNES_gradient(X, reference, degree)
[N, S] = size(X); % N site
                         % S species
if nargin <3
    degree = 1;
end                      
if nargin < 2
        reference = 1 : N;
end
%%
 nes  = nan(N-1, degree);
 sor  = nan(N-1, degree);
 sim = nan(N-1, degree);
 ref  = nan(N-1, degree);
 dif  = nan(N-1, degree);
% ordering sites base on information in `reference`
[y, I] = sort(reference);
ref(:, 1) = mean([y(1:N-1)'; y(2:N)'])';
X = X(I, :);
%%
for d = 1: degree
        for i = 1: N-d    
        A = betaNES_pairwise(X([i, i+d],:));
        nes(i, d) = A.pnes;
        sim(i, d) = A.psim;
        sor(i, d) = A.psor;
        ref(i,d) = mean([y(i)  y( i+ d)]);
        dif(i,d) = y(i + d) - y(i);
        end
end

ind.nes = nes;
ind.sim = sim;
ind.sor = sor;