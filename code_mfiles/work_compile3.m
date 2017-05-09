%% compile from csv data
    bugdata = csvread('data/csvdata/arthropoddata.csv', 1, 1, [1 1 339 178]);

    T1 = readtable('data/csvdata/sampledata.csv', 'ReadVariableNames', true);
    Tsite = readtable('data/csvdata/sitedata.csv', 'ReadVariableNames', true);
    T4 =  readtable('data/csvdata/plantdata.csv', 'ReadVariableNames', true);

    Tguildtaxon =  readtable('data/csvdata/guild_and_taxon.csv', 'ReadVariableNames', true);
    Tguildname =  readtable('data/csvdata/guildname.csv', 'ReadVariableNames', true);
%% combine plant and arthropod data, replace missing values
        T7 = join(T1, T4);
        Tplant = standardizeMissing(T7, 999); % replace missing value with `NaN`
        clear T1 T4 T7
%%
 script_compile_plant3
      plantST = metacommunity( Tplant2{:,:}, Tplant{:, {'Sitecode', 'Monthcode'}} , 'mean') ;
        %% weighted bugdata
        rbugdata = bugdata ./ repmat(Tplant.Part_sampled, 1, 178); % row
        vbugdata =   rbugdata ./ repmat(Tplant.Volume, 1, 178); % volume adjusted
         clear bugdata rbugdata
%% Guilds
  [guildmat, guildlist] = Spp2Guild(vbugdata, Tguildtaxon.guildcode2, [0]);    % ignore guild 0      
  [taxonmat, taxonlist] = Spp2Guild(vbugdata, Tguildtaxon.taxon2, [0]);

%% metacommunity and transformation
    [t_matST, t_infoST] = metacommunity( taxonmat, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;
    [g_matST, g_infoST] = metacommunity( guildmat, Tplant{:, {'Sitecode', 'Monthcode'}} ) ;

    % month and latitude data for metacommunity at sites scale
     monthST = t_infoST(:,2); 
     latitudeST =  Tsite{t_infoST(:,1),{'decimallatitude'}};
%% DATA transformation 
        g_LdataST= log10(g_matST+1);
        t_LdataST= log10(t_matST+1);

%%
    Tplant2name = readtable('data/csvdata/plant_variables.csv', 'ReadVariableNames', true);
     Tplant2name.transformation{6} = '';
 %%
 clear guildlist taxonlist