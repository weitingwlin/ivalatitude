%% script used in work_explore_latitude_trends
    color = mcolor(m - 5);
                style = m - 4;
                ID = m - 5;
     %%%%%%%%%%%%%
    temptab = array2table([Xdata  Ydata], 'Variablenames', {'latitude', name});
    mdl = stepwiselm(temptab, 'quadratic',  'Criterion', 'aic');
    p = coefTest(mdl);
    h{ID} = myplot(temptab.latitude,  temptab{:, name}, 'S', color, style);hold on
    if mdl.NumCoefficients > 1 && p < 0.05
            X = linspace(min(Xdata), max(Xdata), 20);
            Y = predict( mdl, X');                  
            h2{ID} = myplot(X, Y, 'L',  color, style); 
            modelstr{ID} =  strjoin( mdl.CoefficientNames, ' + ');
    else 
            h2{ID} = [];
            modelstr{ID} = [];
    end
    

            

 