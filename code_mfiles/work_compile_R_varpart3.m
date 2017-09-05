% This is a master work file that compile/transform data into data tables
% before doing partitioning of variation in R
% ` work_compile_R_varpart`

clear;clc
work_setup
work_compile3

%% compiling, tranforming the plant data
    plantdata = Tplant2{:,[1,2, 4,5,7,8]};
    plantdatanames = Tplant2(:,[1,2, 4,5,7,8]).Properties.VariableNames;
            Lplant = plantdata; 
            % graph  with `work_explore_plant` to see justification 
%% guild data
  %  [guildmat, guildlist] = Spp2Guild( bugdata, guild2, 0 );
%% month, latitude info
    info = [Tsite.decimallatitude(Tplant.Sitecode), Tplant.Monthcode];
%% summing sample data to a site-month scales
    [LplantST] = metacommunity( Lplant, Tplant{:, {'Sitecode', 'Monthcode'}}, 'mean' ) ;

%% remove the datarow with NAN
             ind_in = find(any(isnan(plantdata), 2)==0); % index of "in" data
%% write to csv
csvwrite( [ rdatapath '/Yt_PL.csv'], taxonmat(ind_in, :) ); % taxa data, by plant (sample, beat)
csvwrite( [ rdatapath '/Yt_ST.csv'], t_matST ); % taxa data, sumed over site and time

csvwrite([ rdatapath '/Yg_PL.csv'], guildmat(ind_in, :)  ); % guild data, by plant (sample, beat)
csvwrite([ rdatapath  '/Yg_ST.csv'], g_matST ); % guild data, sumed over site and time

csvwrite( [ rdatapath '/Xs_PL.csv'],  info(ind_in, :) ); % time-latitude data, by plant (sample, beat)
csvwrite( [ rdatapath '/Xs_ST.csv'], [latitudeST   t_infoST(:,2)]); % time-latitude data, sumed over site and time

csvwrite([ rdatapath  '/Xe_PL.csv'], Lplant(ind_in, :)  ); % plant (environment) data, by plant (sample, beat)
csvwrite([ rdatapath  '/Xe_ST.csv'], LplantST(ind,:) ); % plant data, sumed over site and time


