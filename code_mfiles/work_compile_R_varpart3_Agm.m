% This is a master work file that compile/transform data into data tables
% before doing partitioning of variation in R
% ` work_compile_R_varpart`
  clear;clc
   work_setup
   work_compile3

%% compiling, tranforming the plant data
    plantdata_Agm = Tplant2{:,[1, 4,5]};
    plantdatanames_Agm = Tplant2(:,[1, 4,5]).Properties.VariableNames;
            Lplant_Agm = plantdata_Agm; 
            % graph  with `work_explore_plant` to see justification 
%% Plant scale
     % Agm: Transform and rescale
        L_Agm = Tplant2{:, [2 7 8]}; % Armases, galls, miners. Transformed
        L_Agm_rs = (  L_Agm - repmat((mean(  L_Agm )), 339, 1))  ./  repmat((std(  L_Agm)), 339, 1);
               % rescaled respectively
      % Taxon         
        L_taxon =  log10( taxonmat + 1 ) ;
        L_taxon_rs = ( L_taxon - mean( L_taxon(:) ) ) ./  std( L_taxon(:) );
        
        L_taxonPL_Agm_rs = [ L_taxon_rs   L_Agm_rs ];
     %  Guild
         L_guild =  log10( guildmat + 1 ) ;
         L_guild_rs = ( L_guild - mean( L_guild(:) ) ) ./  std( L_guild(:) );  
     
         L_guildPL_Agm_rs = [ L_guild_rs   L_Agm_rs ];
      
%% Site scale    
       
        AgmST = metacommunity( Tplant{:,[6 11 12]}, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;
        AgmST = AgmST(ind, :); % only include sites with 8 replicates, 
        % transformation
        LAgmST = [log10(AgmST(:, 1) + 1)  asin(sqrt(AgmST(:, [2 3]) ./ 240))];
        % rescale the transformed data  
        LAgmST_rs = (LAgmST - repmat((mean(LAgmST)), 40, 1))  ./  repmat((std(LAgmST)), 40, 1);

    % taxon            
         L_taxon_ST_rs = ( t_LdataST - mean(t_LdataST(:)) ) ./  std(t_LdataST(:));
         L_taxonST_Agm_rs  = [ L_taxon_ST_rs,   LAgmST_rs ];

     % guild     
         L_guild_ST_rs = ( g_LdataST - mean(g_LdataST(:)) ) ./  std(g_LdataST(:));
         L_guildST_Agm_rs  = [  L_guild_ST_rs,   LAgmST_rs ];
   
%% month, latitude info
    info = [Tsite.decimallatitude(Tplant.Sitecode), Tplant.Monthcode];
%% summing sample data to a site-month scales
    [LplantST_Agm] = metacommunity( Lplant_Agm, Tplant{:, {'Sitecode', 'Monthcode'}}, 'mean' ) ;

%% remove the datarow with NAN
             ind_in = find(any(isnan(plantdata_Agm), 2)==0); % index of "in" data
%% write to csv
csvwrite( [ rdatapath '/Yt_PL.csv'], L_taxonPL_Agm_rs(ind_in, :) ); % taxa data, by plant (sample, beat)
csvwrite( [ rdatapath '/Yt_ST.csv'], L_taxonST_Agm_rs); % taxa data, sumed over site and time

csvwrite([ rdatapath '/Yg_PL.csv'], L_guildPL_Agm_rs(ind_in, :)  ); % guild data, by plant (sample, beat)
csvwrite([ rdatapath  '/Yg_ST.csv'], L_guildPL_Agm_rs ); % guild data, sumed over site and time

csvwrite( [ rdatapath '/Xs_PL.csv'],  info(ind_in, :) ); % time-latitude data, by plant (sample, beat)
csvwrite( [ rdatapath '/Xs_ST.csv'], [latitudeST   t_infoST(:,2)]); % time-latitude data, sumed over site and time

csvwrite([ rdatapath  '/Xe_PL.csv'], Lplant_Agm(ind_in, :)  ); % plant (environment) data, by plant (sample, beat)
csvwrite([ rdatapath  '/Xe_ST.csv'],  Lplant_Agm(ind, :) ); % plant data, sumed over site and time


