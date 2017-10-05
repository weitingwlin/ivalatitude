%% explore taxon/guild spatial/temporal autocorrelation  
clear t_LdataST  g_LdataST
%% Taxon, Euclidean
 [t_r, t_p] = f_mantel(squareform(pdist( t_LdataST_gm)),  squareform(pdist(  latitudeST)), 0, 10000);
 [t_r2, t_p2] = f_mantel(squareform(pdist( t_LdataST_gm)),  squareform(pdist(monthST)), 0, 10000);

  indexstr = 'Euclidean';
 disp(['Latitudinal ', indexstr , ' (taxon) :    r = ', num2str(t_r, 3), ';  ', pstring(t_p) ])
 disp(['Temporal', indexstr , ' (taxon) :       r = ', num2str(t_r2, 3), ';  ', pstring(t_p2) ])
 clear t_r  t_p t_r2 t_p2
%% Taxon, MSR
  t_betaMSR = squareform(betaMRS_pairwise(t_matST_gm) );
        [t_r, t_p] = f_mantel( t_betaMSR,  squareform(pdist(latitudeST )), 0, 10000);
        [t_r2, t_p2] = f_mantel( t_betaMSR,  squareform(pdist(monthST )), 0, 10000);

  indexstr = 'MRS';
 disp(['Latitudinal ', indexstr , ' (taxon) :    r = ', num2str(t_r, 3), ';  ', pstring(t_p) ])
 disp(['Temporal', indexstr , ' (taxon) :       r = ', num2str(t_r2, 3), ';  ', pstring(t_p2) ])
 clear t_r  t_p t_r2 t_p2
%%   
 t_betaNES = betaNES_pairwise(t_matST_gm) ;
    %d = mean(betaNES.psim);
     [t_r, t_p] = f_mantel(squareform(t_betaNES.pnes),  squareform(pdist([latitudeST ])), 0, 10000);
     [t_r2, t_p2] = f_mantel(squareform(t_betaNES.pnes),  squareform(pdist([monthST ])), 0, 10000);
  indexstr = 'Nestedness';
 disp(['Latitudinal ', indexstr , ' (taxon) :    r = ', num2str(t_r, 3), ';  ', pstring(t_p) ])
 disp(['Temporal  ', indexstr , ' (taxon) :     r = ', num2str(t_r2,3), ';  ', pstring(t_p2) ])
  clear t_r  t_p t_r2 t_p2
%%
     [t_r, t_p] = f_mantel(squareform(t_betaNES.psim),  squareform(pdist([latitudeST ])), 0, 10000);
     [t_r2, t_p2]= f_mantel(squareform(t_betaNES.psim),  squareform(pdist([monthST ])), 0, 10000);
  indexstr = 'Simpson';
disp(['Latitudinal ', indexstr , ' (taxon) :    r = ', num2str(t_r, 3), ';  ', pstring(t_p) ])
disp(['Temporal  ', indexstr , ' (taxon) :     r = ', num2str(t_r2, 3), ';  ', pstring(t_p2) ])
   clear t_r  t_p t_r2 t_p2
%% Guild, Euclidean
 [g_r, g_p] = f_mantel(squareform(pdist( g_LdataST_gm)),  squareform(pdist(  latitudeST)), 0, 10000);
 [g_r2, g_p2] = f_mantel(squareform(pdist( g_LdataST_gm)),  squareform(pdist(monthST)), 0, 10000);

  indexstr = 'Euclidean';
 disp(['Latitudinal ', indexstr , ' (guild) :    r = ', num2str(g_r, 3), ';  ', pstring(g_p) ])
 disp(['Temporal', indexstr , ' (guild) :       r = ', num2str(g_r2, 3), ';  ', pstring(g_p2) ])
 clear g_r  g_p g_r2 g_p2
   %% guild-based MRS
  g_betaMSR = squareform(betaMRS_pairwise(g_matST_gm) );
        [g_r, g_p] = f_mantel( g_betaMSR,  squareform(pdist(latitudeST )), 0, 10000);
        [g_r2, g_p2] = f_mantel( g_betaMSR,  squareform(pdist(monthST )), 0, 10000);   
 indexstr = 'MRS';
 disp(['Latitudinal ', indexstr , ' (guild) :    r = ', num2str(g_r, 3), ';  ', pstring(g_p) ])
 disp(['Temporal ', indexstr , ' (guild) :      r = ', num2str(g_r2, 3), ';  ', pstring(g_p2) ])
 clear g_r  g_p g_r2 g_p2
%% guild  
 g_betaNES = betaNES_pairwise(g_matST_gm) ;
    %d = mean(betaNES.psim);
     [g_r, g_p] = f_mantel(squareform(g_betaNES.pnes),  squareform(pdist([latitudeST ])), 0, 10000);
     [g_r2, g_p2] = f_mantel(squareform(g_betaNES.pnes),  squareform(pdist([monthST ])), 0, 10000);
  indexstr = 'Nestedness';
 disp(['Latitudinal ', indexstr , ' (guild) :    r = ', num2str(g_r, 3), ';  ', pstring(g_p) ])
 disp(['Temporal ', indexstr , ' (guild) :      r = ', num2str(g_r2, 3), ';  ', pstring(g_p2) ])
 clear g_r  g_p g_r2 g_p2
%%
     [g_r, g_p] = f_mantel(squareform(g_betaNES.psim),  squareform(pdist([latitudeST ])), 0, 10000);
     [g_r2, g_p2]= f_mantel(squareform(g_betaNES.psim),  squareform(pdist([monthST ])), 0, 10000);
  indexstr = 'Simpson';
 disp(['Latitudinal ', indexstr , ' (guild) :    r = ', num2str(g_r, 3), ';  ', pstring(g_p) ])
 disp(['Temporal ', indexstr , ' (guild) :      r = ', num2str(g_r2, 3), ';  ', pstring(g_p2) ])
 clear g_r  g_p g_r2 g_p2