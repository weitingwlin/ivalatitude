 % prepare data 
  Xname = {Tplant2name.x__{iX}, [Tplant2name.transformation{iX}]};

  % making scatter plot
  
  h1 = scatter(X, Y, 60, latitudeSample, 'filled','Markerfacealpha',0.7);
      colormap(mymap)
       set(gca,'FontSize',14,'linewidth',2);  
  h2 = colorbar;
  h2.Label.String = 'Latitude';
  h2.Label.FontSize = 16;
       set(h2,'FontSize',14,'linewidth',2); 
  xlabel( Xname ,'FontSize',18 );
  ylabel([Tguildname.guildname( Tguildname.guildcode == iY ), 'log_1_0( n +1 )' ],'FontSize',18);

  % stepwise linear regression
    % pack data into a table (z-score standardize the predicting variables)
    temptab = array2table([nanzscore(Y), nanzscore(X),  monthSample,  latitudeSample], ...
                                           'Variablenames', {'N', 'Var', 'month', 'Latitude'});
    % run stepwise regression
  %  mdls = stepwiselm( temptab, [ 'N ~ Var + Var^2 + Latitude + Latitude^2' ],  'Criterion', 'aic');
  % run quadrat lm
  mdl = fitlm(temptab{:,3:4}, temptab{:, 1}, 'quadratic');
  residST = mdl.Residuals.Raw;
  temptab2 = array2table([ residST, nanzscore(X)], ...
                                           'Variablenames', {'Nres', 'Var'});
    mdls = fitlm( temptab2, 'Nres ~ Var  ' );
    % extracting the results (model selected)
    p = coefTest(mdls); % p value
    x =  mdls.CoefficientNames; % names of the variables
    coef = mdls.Coefficients.Estimate; % coefficents
    % ... and prepare the string (first term is the intercept)
     mdlstring = ['Y ~ ' num2str(coef(1),2)];
        if length(coef) >= 2
                for i = 2 : length(coef)
                        mdlstring = [mdlstring  ' + ' num2str(coef(i), 2) ' (' x{i} ')']; 
                end
        end
     % print on the graph
        title({pstring(p),  mdlstring , '(predicting variables are z-scored)'})
        