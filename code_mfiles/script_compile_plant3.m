  %% load plant data
  % plantdata = load('./data/plant.txt');  
  %  plantdata(plantdata==999) = NaN;
  % sampledata_plant = load('./data/sampledata_plant.txt');
  % plantdatanames = readcell('./data/plantnames.txt');
  
  % creat a master plant data table
 % Tplant = array2table(plantdata, 'VariableNames', plantdatanames);
 % Tsampleplant = array2table(sampledata_plant,'VariableNames',    sampledatanames(1:3) );
%  temp = [Tsampleplant  Tplant];
 % join data with sample
% Tplant = join(Tsample, temp);
 %%
 Tplant.Area =  Tplant.Width .* Tplant.Depth;
 Tplant.Volume = Tplant.Height  .* Tplant.Area;
 Tplant.toughness = nanmean(Tplant{:,{'Toughness1'  ,  'Toughness2',    'Toughness3'}},2);
 Tplant.Volsampled = Tplant.Volume .* Tplant.Part_sampled;
 Tplant.latitude = Tsite{Tplant.Sitecode,{'decimallatitude'}}; % latitude correspond to each sample
 %%
 % for reasoning see work_explore_plant.m
 % plantdata = Tplant{:,[5,6,8,11,12, 17,18, 19]};
 % plantdatanames = tnames(Tplant(:,[5,6,8,11,12, 17,18, 19]));
 %  Lplant = plantdata; 
        log_name =  strcat('Log',Tplant.Properties.VariableNames([5 6 17 18 19]));
        log_data = log(Tplant{:, [5 6 17 18 19]} + 1);
  Tlog = array2table(log_data, 'VariableNames', log_name);  
        assr_name =  strcat('Assr',Tplant.Properties.VariableNames([11 12]));
        assr_data =  asin(sqrt(Tplant{:, [11 12]} ./ 30 ));
  Tassr = array2table(assr_data, 'VariableNames', assr_name);   
  Tplant2 = [Tlog  Tplant(:,'Height') Tassr]; 
 %  Lplant(:,[1 2 6 7 8]) = log(plantdata(:,[ 1 2  6 7 8])+1);
 %  Lplant(:, [4 5]) = asin(sqrt(Lplant(:, [4 5])./30));
 %%
 %temp = cell2table( Tplant2.Properties.VariableNames', 'VariableNames', {'variable'});
 Plant_namestr = {'Wrack (log)', 'Armases in 4 m^2 (log)', 'Plant area (log)', 'Plant volume (log)', ... 
                'Leave toughness (log)', 'Plant height', 'Leave galls ratio (asin-sqrt)', 'Leave miners ratio (asin-sqrt)'};
%  temp2 = cell2table(  Plant_namestr, 'VariableNames', {'variable'});     
 %%
 clear Tlog Tassr log_data log_name assr_data assr_name