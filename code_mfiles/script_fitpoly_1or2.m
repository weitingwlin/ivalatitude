%% script used in work_abundance_pattern
    latST = siteinfo(g_infoST(:,1),2);
    monST =g_infoST(:,2);
      subg =log10( g_matST(:,g) + 1);
     gtab=  table(subg,  latST , monST);
     %% model fitting
         mdls = stepwiselm(gtab, 'subg ~ latST + latST^2 + monST',  'Criterion', 'aic');
          x =  mdls.CoefficientNames;
        
         candidate = {'latST', 'latST^2', 'monST', 'latST:monST' , 'latST^2:monST' };
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
         mstyle = [1.5 7 1];
%%
        if p >= 0.05
                model = 'none';
        else   
                model = join(x, ' + ');
                if any(inmodel(3:5) ~= 6) % month in the picture
                        for m = 6:8
                                        ind = (g_infoST(:,2)==m);
                                        subgm  = subg(ind);
                                        [xData, yData] = prepareCurveData(siteinfo(:,2), subgm );
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
                         [xData, yData] = prepareCurveData(siteinfo(g_infoST(:,1),2), subg );
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
  