%%  **work\_explore\_latitude\_trend.m**
%% preparing data
    clear;clc

    work_compile3
    guildlog = log10(guildmat + 1) ;

    mymap =     flipud(parula);
%%
plantscale = zeros(8, 10);
sitescale = zeros(8,10);
%% making residual guild  matrix
    latitudeSample = Tsite.decimallatitude(Tplant.Sitecode); 
    monthSample =  Tplant.Monthcode;
    resT = [];
for iY = 1: 7 % guild
        Y = guildlog(:, iY);
        temptab = array2table([Y,  monthSample,  latitudeSample], ...
                                                'Variablenames', {'N', 'month', 'Latitude'});
        mdl = fitlm(temptab{:, 2:3}, temptab{:, 1}, 'quadratic');
        residST = array2table(mdl.Residuals.Raw, 'Variablenames', {['redsidual_', num2str(iY)]});
        resT = [resT, residST];
end
 %%
 mycorrplot_2(resT, Tplant2,Tguildname.camel, Tplant2.Properties.VariableNames, 'T', [1 0 0]);
 mysubplot(1, 8, 0, {'Correlation between residual of abundance and plant variables', 'Site scale'})

%%
        for iX = 3 % plant variables
                X = Tplant2{:,iX};        
                figure
                script_plant_to_guild  
                if any(strcmp('Var', x),2)
                        plantscale(iX, iY)=  coef(strcmp('Var',x));
                end
        end

%%

 latitudeSample = latitudeST;
 monthSample = t_infoST(:,2);
     resTsite =[];
 for iY =  1:7
      Y = log(g_matST(:, iY) + 1);
           temptab = array2table([Y,  monthSample,  latitudeSample], ...
                                                'Variablenames', {'N', 'month', 'Latitude'});
        mdl = fitlm(temptab{:, 2:3}, temptab{:, 1}, 'quadratic');
        residST = array2table(mdl.Residuals.Raw, 'Variablenames', {['redsidual_', num2str(iY)]});
        resTsite = [resTsite, residST];
 end
 %%
 mycorrplot_2(resTsite, plantST, Tplant2.Properties.VariableNames,[], 'T', [1 0 0]);
 mysubplot(1, 8, 0, {'Correlation between residual of abundance and plant variables', 'Site scale'})
 %%
 for iY = 1:10 % guild
        for iX = 1:8 % plant variables
                X = plantST(:,iX);
                Y = log(g_matST(:, iY) + 1);
                %figure
                script_plant_to_guild  
                if any(strcmp('Var', x),2)
                        sitescale(iX, iY)=  coef(strcmp('Var',x));
                end
        end
end     
 %%
  [im, hcb] = mytable(sitescale, 'blue', 14, [], [],2, 'yellow');
 