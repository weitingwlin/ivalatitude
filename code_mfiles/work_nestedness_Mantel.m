%% explore bete-diversity pattern vs. latitudinal distance
% Mantel correlation
clear;clc
work_compile

lat_Dissim = pdist([latitudeST ]);
%%
% by month
for m = 1 : 3
     g_Dissim_m{m} = pdist(  g_LdataST(infoST(:,2)==month(m), : ) ) ;
                g_out =  betaNES_pairwise(  g_LdataST(infoST(:,2)==month(m), : ) );
            g_sim_m{m} = g_out.psim;  
            g_sor_m{m} = g_out.psor;  
            g_nes_m{m} = g_out.pnes;  
     t_Dissim_m{m} = pdist( LdataST(infoST(:,2)==month(m), : ) );
                 t_out =  betaNES_pairwise(  LdataST(infoST(:,2)==month(m), : ) );
            t_sim_m{m} = t_out.psim;  
            t_sor_m{m} = t_out.psor;  
            t_nes_m{m} = t_out.pnes; 
     lat_Dissim_m{m} = pdist( latitudeST(infoST(:,2)==month(m), : ) );
end
%%
mantelit = 1000;
X = lat_Dissim_m; % past to `script_explore_mantel_plot`
        gr(1,:) = nestedness_mantel(X, g_sor_m, mantelit);
        gr(2,:) = nestedness_mantel(X, g_sim_m, mantelit);
        gr(3,:) = nestedness_mantel(X, g_nes_m, mantelit);
        tr(1,:) = nestedness_mantel(X, t_sor_m, mantelit);
        tr(2,:) = nestedness_mantel(X, t_sim_m, mantelit);
        tr(3,:) = nestedness_mantel(X, t_nes_m, mantelit);
      

%% plot of "r" size
figure
    scatter([1 1 1 2 2 2 3 3 3],[ 1 2 3 1 2 3 1 2 3]/2 ,  abs( gr(:))*1000, gr(:)<0, 'filled')
            text(-1.2 , 0.5 , ' \beta _S_o_r (Total)', 'Fontsize', 14)
            text(-1.2 , 1 , ' \beta _S_i_m (Turnover)', 'Fontsize', 14)
            text(-1.2 , 1.5 , ' \beta _N_e_s (Nestedness)', 'Fontsize', 14)
            text(1 , 1.8 , ' June', 'Fontsize', 14, 'HorizontalAlignment', 'center')
            text(2 , 1.8 , ' July', 'Fontsize', 14, 'HorizontalAlignment', 'center')
            text(3 , 1.8 , ' August', 'Fontsize', 14, 'HorizontalAlignment', 'center')
        axis([-1.3 5 0 2])
        axis off
        title({'Guild based', '(r)'}, 'Fontsize', 16)
figure
    scatter([1 1 1 2 2 2 3 3 3],[ 1 2 3 1 2 3 1 2 3] /2,  abs(tr(:))*1000, tr(:)<0,  'filled')
            text(-1.2 , 0.5 , ' \beta _S_o_r (Total)', 'Fontsize', 14)
            text(-1.2 , 1 , ' \beta _S_i_m (Turnover)', 'Fontsize', 14)
            text(-1.2 , 1.5 , ' \beta _N_e_s (Nestedness)', 'Fontsize', 14)
            text(1 , 1.8 , ' June', 'Fontsize', 14, 'HorizontalAlignment', 'center')
            text(2 , 1.8 , ' July', 'Fontsize', 14, 'HorizontalAlignment', 'center')
            text(3 , 1.8 , ' August', 'Fontsize', 14, 'HorizontalAlignment', 'center')
        axis([-1.3 5 0 2])
        axis off
        title({'Taxon based', '(r)'}, 'Fontsize', 16)

%% devise some index of relative nestedness
