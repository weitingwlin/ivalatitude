function betas = betaNES_pairwise(matin) 
% 
% work as if  we pass each pair of communities to betaNES and return somthing like the
% result of pdist
matin01 = matin > 0; % to a presence-absence matrix
                              % the rest base on this
[ N, P ] = size(matin);

sim = zeros(N);
sor = zeros(N);
nes = zeros(N);

for i = 1 : (N-1)
        for j = (i + 1) : N % this is how you get all unique paires
               alphas = sum(matin01([i, j], :), 2); % alpha richness
               gamma = sum( sum( matin01([i,j], :) ) > 0 , 2); % total number of species   
               a = sum(alphas) - gamma; % multi-site a
               b = ((matin01(i, :) == 1) +  (matin01(j, :) == 0)) == 2   ; % present in one site not the other
               c = ((matin01(i, :) == 0) +  (matin01(j, :) == 1)) == 2   ;
               minb = min( [ sum(b) sum(c) ] ); % add up
               maxb = max( [ sum(b) sum(c) ] );
               % calculate pairwise betas
                sor(i, j) = (minb + maxb)/(2*a + minb +maxb);   sor(j, i) = sor(i, j);
                sim(i, j) = minb/(a + minb);                                  sim(j, i) = sim(i, j);
                nes(i, j) = sor(i, j) - sim(i, j);                               nes(j, i) = nes(i, j);
        end
end

%% 
betas.psim = squareform( sim );
betas.psor = squareform( sor );
betas.pnes =squareform( nes );