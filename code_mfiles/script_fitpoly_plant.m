%% script used in work_abundance_pattern
    lat =  Tsite{infoST(:,1), {'decimallatitude'}};
    month= infoST(:,2); 
     % subg =log10( g_matST(:,g) + 1);
     gtab=  table(subg,  lat , month);
     %% model fitting
         mdls = stepwiselm(gtab, 'subg ~ lat + lat^2 + month',  'Criterion', 'aic');
          x =  mdls.CoefficientNames;
        
         candidate = {'lat', 'lat^2', 'month', 'lat:month' , 'lat^2:month' };
         inmodel = zeros(1,5);
         for c = 1:5
             ind = strmatch(candidate{c},  x,'exact');
             if ~isempty(ind)
                 inmodel(c) = ind;
             else
                   inmodel(c) = 6;
             end
         end
         p = coefTest(mdls);
        %  x = char(split(mdls.Formula.LinearPredictor , ' + '))
         mlstyle = [3 2 2];
         mstyle = [1.5 17 7];
%%

        if p >= 0.05 ||  length(x) == 1
            %    model = 'none';
        else   
            %    model = join(x, ' + ');
                if any(inmodel(3:5) ~= 6) % month in the picture
                        for m = 6:8
                                        ind = (infoST(:,2)==m);
                                        subgm  = subg(ind);
                                        sublat = Tsite.decimallatitude(infoST(ind,1));
                                        [xData, yData] = prepareCurveData( sublat  , subgm );
                                       xPrid = linspace(min(xData), max(xData), 100);
                                          Cs = mdls.Coefficients.Estimate; Cs(6) = 0; % a dummy for not
                                       yPrid = Cs(1) + ...
                                                  xPrid .* Cs(inmodel(1)) +...
                                                  xPrid .^ 2  .* Cs(inmodel(2)) + ...
                                                  m .* Cs(inmodel(3))  + ... 
                                                  xPrid .* m .* Cs(inmodel(4)) + ...
                                                  xPrid .^ 2  .* m .* Cs(inmodel(5)) ;
                                       myplot(xPrid, yPrid, 'L', floor(mstyle(m-5)), mlstyle(m-5) );
                        end
                else % month not in the picture
                         [xData, yData] = prepareCurveData(Tsite.decimallatitude(infoST(:,1)), subg );
                                       xPrid = linspace(min(xData), max(xData), 100);
                                          Cs = mdls.Coefficients.Estimate; Cs(6) = 0; % a dummy for not
                                       yPrid = Cs(1) + ...
                                                  xPrid .* Cs(inmodel(1)) +...
                                                  xPrid .^ 2  .* Cs(inmodel(2)) + ...
                                                  m .* Cs(inmodel(3))  + ... 
                                                  xPrid .* m .* Cs(inmodel(4)) + ...
                                                  xPrid .^ 2  .* m .* Cs(inmodel(5)) ;
                                       myplot(xPrid, yPrid, 'L', 1, 1);
                end
        end
  %%
    pstr = pstring(p);
 if   length(x) > 1
    pstr = '';
 end
%%
 tab{row, 1} = ystr;
tab{row, 2}  = modelString(mdls, '~');
tab{row, 3}  = num2str(mdls.Rsquared.Adjusted, 2 );
tab{row, 4}  = pstring( mdls.coefTest);
if    length(x) < 1
    tab{row, 3}  = 'N/A'; 
    tab{row, 4}  = 'N/A';
end
