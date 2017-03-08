% This is a master work file that compile/transform data into data tables
% before doing partitioning of variation in R
% ` work_compile_R_varpart`

clear;clc
work_compile3

%% compiling, tranforming the plant data
    plantdata = Tplant{:,[5,6,8,11,12, 17,18, 19]};
    plantdatanames = tnames(Tplant(:,[5,6,8,11,12, 17,18, 19]));
            Lplant = plantdata; 
            Lplant( :, [1 2 6 7] ) = log( plantdata( :, [ 1 2  6 7 ] ) + 1 );
            Lplant( :, [4 5] ) = asin( sqrt( Lplant( :, [4 5] ) ./ 30 ) );

            % graph  with `work_explore_plant` to see justification 
%% guild data
  %  [guildmat, guildlist] = Spp2Guild( bugdata, guild2, 0 );
%% month, latitude info
    info = sampledata(:, [1, 2] );
%% summing sample data to a site-month scales
    [LplantST] = metacommunity( Lplant, sampledata(:, [1, 2] ), 'mean' ) ;
    [t_matST, t_infoST] = metacommunity( taxonmat, sampledata(:, [1, 2] ) ) ; % left the transformation (if any) to R
    [g_matST, g_infoST] = metacommunity( guildmat, sampledata(:, [1, 2] ) ) ;
%% remove the datarow with NAN
             ind_in = find(any(isnan(plantdata), 2)==0); % index of "in" data
%% write to csv
csvwrite( 'Rfiles/Rdata/Yt_PL.csv', taxonmat(ind_in, :) ); % taxa data, by plant (sample, beat)
csvwrite( 'Rfiles/Rdata/Yt_ST.csv', t_matST ); % taxa data, sumed over site and time

csvwrite( 'Rfiles/Rdata/Yg_PL.csv', guildmat(ind_in, :)  ); % guild data, by plant (sample, beat)
csvwrite( 'Rfiles/Rdata/Yg_ST.csv', g_matST ); % guild data, sumed over site and time

csvwrite( 'Rfiles/Rdata/Xs_PL.csv',  [siteinfo(info(ind_in, 1), 2)   info(ind_in,2)] ); % time-latitude data, by plant (sample, beat)
csvwrite( 'Rfiles/Rdata/Xs_ST.csv', [siteinfo(t_infoST(:,1), 2)   t_infoST(:,2)]); % time-latitude data, sumed over site and time

csvwrite( 'Rfiles/Rdata/Xe_PL.csv', Lplant(ind_in, :)  ); % plant (environment) data, by plant (sample, beat)
csvwrite( 'Rfiles/Rdata/Xe_ST.csv', LplantST ); % plant data, sumed over site and time