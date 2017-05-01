%%  **work\_explore\_latitude\_trend.m**
%% preparing data
    clear;clc

    work_compile3
    guildlog = log10(guildmat + 1) ;


    mymap =     flipud(parula);
%%
plantscale = zeros(8, 10);
%%
    latitudeSample = Tsite.decimallatitude(Tplant.Sitecode); 
for iY = 2 % guild
        for iX = 1:8 % plant variables
                X = Tplant2{:,iX};
                Y = guildlog(:, iY);
                
                script_plant_to_guild  
                if any(strcmp('Var', x),2)
                        plantscale(iX, iY)=  coef(strcmp('Var',x));
                end
        end
end

%%
Xname = {Tplant2name.x___X{iX}, [Tplant2name.transformation{iX}]};
 latitudeSample = latitudeST;
  X = plantST(:,iX);
  Y = g_matST(:, iY);
      script_plant_to_guild
 %%