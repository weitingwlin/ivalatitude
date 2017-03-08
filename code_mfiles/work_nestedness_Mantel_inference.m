%% Statistical inferences extending from work_explore_mantel
% run the first two blocks of `work_nestedness_Mantel`
%%
mantelit = 10000;
X = lat_Dissim_m; % past to `script_explore_mantel_plot`

for m = 1: 3 
    % [BS{m}] = nanls(X{m}, Y{m});
        [r_gsor, p] = f_mantel( squareform( X{m} ),  squareform(g_sor_m{m} ), 0, mantelit);
        [r_gsim, p] = f_mantel( squareform( X{m} ),  squareform(g_sim_m{m} ), 0, mantelit);
        [r_gnes, p] = f_mantel( squareform( X{m} ),  squareform(g_nes_m{m} ), 0, mantelit);
        gnes(m) = r_gnes/r_gsor;
end
        %    slopes = [BS{1}(2), BS{2}(2), BS{3}(2)];
         %   rs = [r{1}, r{2}, r{3}];
 %% null model
  it = 100;
    nullgnes = zeros(it, m) ;
tic
    parfor i=1:it
        nullguild = datasample(guild2, length(guild2), 'Replace', false);
        [nullguildmat, guildlist] = Spp2Guild(bugdata, nullguild, [0]);
        [nullg_matST, g_infoST] = metacommunity( nullguildmat, sampledata(:, [1, 2] ) ) ;
        nullg_LdataST= log(nullg_matST+1);
        % nullDissim = pdist(nullg_LdataST);
        for m = 1 : 3
               % g_Dissim_m{m} = pdist(  g_LdataST(infoST(:,2)==month(m), : ) ) ;
                g_out =  betaNES_pairwise(  nullg_LdataST(infoST(:,2) == month(m), : ) );
             %   g_sim_m = g_out.psim;  
                g_sor_m = g_out.psor;  
                g_nes_m = g_out.pnes;  
                [r_gsor, p] = f_mantel( squareform( X{m} ),  squareform(g_sor_m ), 0, mantelit);
             %   [r_gsim, p] = f_mantel( squareform( X{m} ),  squareform(g_sim_m ), 0, mantelit);
                [r_gnes, p] = f_mantel( squareform( X{m} ),  squareform(g_nes_m ), 0, mantelit);
                nullgnes(i, m) = r_gnes/r_gsor;
         end
    end
  runtime = toc; 
  disp([ 'Run time is ' num2str(runtime) ' seconds for '  num2str(it) ' iterations' ])
%%
 mysubplot(3, 1, 0 , { 'Nestedness vs. null model'; 'ratio of mental correlation (r_n_e_s/r_s_o_r)'} )
for m=1:3
  mysubplot(3,1, m)
              edges = [-20 -10:0.5:10 20];
        histogram(nullgnes(:,m), edges); hold on
        q1 = quantile(nullgnes(:,m), [0.025 0.5 0.975],1);
        vline(q1(1), 7, ':'); vline(q1(2), 7, '--');   vline(q1(3), 7, ':'); 
        vline( gnes(m), 2);
                pctile =  (sum(nullgnes <  gnes(m))+sum(nullgnes ==  gnes(m))*0.5)/it
        title([num2month(month(m)) ';  p = ' num2str(pctile)])
        xlim([-10 10])
end
        xlabel('Relative effect (r) of nestedness')
