%%
  for m = 6:8
              indm = mdata == m;
               myplot(Xdata(indm), Ydata(indm), 'S', mstyle(m-5), m-5); hold on            
  end
%%   
   temptab = array2table([Ydata, Xdata,  mdata], 'Variablenames', {index, 'lat', 'month'});
%%
   mdls = stepwiselm( temptab, [index ' ~ lat + lat^2 + month'],  'Criterion', 'aic');
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



        if p >= 0.1 ||  length(x) == 1
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
%%
pstr = pstring(p, [], 2);
if  length(x) == 1
    pstr = '';
   % model = '(intersept)';
end
%% fill in table
tab{row, 1} = type;
tab{row, 2} = index;
tab{row, 3}  = modelString(mdls, '~');
tab{row, 4}  = num2str(mdls.Rsquared.Adjusted, 2 );
tab{row, 5}  = pstring( mdls.coefTest);
if   length(x) == 1
    tab{row, 4}  = 'N/A'; 
    tab{row, 5}  = 'N/A';
end

%%
      xlim([30 43])
            xlabel('latitude', 'fontsize', 20); 
               title({pstr}, 'fontsize', 16);
                ylabel({[ type,' '], index}, 'fontsize', 20);