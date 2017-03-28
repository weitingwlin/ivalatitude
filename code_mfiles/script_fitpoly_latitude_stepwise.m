%%
  for m = 6:8
              indm = mdata == m;
               myplot(Xdata(indm), Ydata(indm), 'S', mstyle(m-5), m-5); hold on            
  end
%%   
   temptab = array2table([Ydata, Xdata,  mdata], 'Variablenames', {name, 'lat', 'month'});
%%
   mdls = stepwiselm( temptab, [name ' ~ lat + lat^2 + month'],  'Criterion', 'aic');
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
  model = join(x, ' + ');
        if p >= 0.1
             %   model = 'none';
        else   
               % model = join(x, ' + ');
                if any(inmodel(3:5) ~= 6) % month in the picture
                        for m = 6:8
                                        ind = (mdata == m);
                                        Ydatam  = Ydata(ind);
                                        Xdatam = Xdata(ind);
                                        [xData, yData] = prepareCurveData(Xdatam , Ydatam );
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
                         [xData, yData] = prepareCurveData(Xdata, Ydata );
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
  