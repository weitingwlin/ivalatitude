 % prepare data 
  Xname = {Tplant2name.x___X{iX}, [Tplant2name.transformation{iX}]};

  % run quadratic model to control for latitude and time
    temptab = array2table([nanzscore(Y), nanzscore(X),  monthSample,  latitudeSample], ...
                                           'Variablenames', {'N', 'Var', 'month', 'Latitude'});
    mdl = fitlm(temptab{:,3:4}, temptab{:, 1}, 'quadratic');
    residST = mdl.Residuals.Raw;
    temptab2 = array2table([ residST, nanzscore(X)], ...
                                           'Variablenames', {'Nres', 'Var'});
    mdls = fitlm( temptab2, 'Nres ~ Var  ' );
    % extracting the results (model selected)
  %  p = coefTest(mdls); % p value
   % x =  mdls.CoefficientNames; % names of the variables
  %  coef = mdls.Coefficients.Estimate; % coefficents
    % ... and prepare the string (first term is the intercept)
   %  mdlstring = ['Y ~ ' num2str(coef(1),2)];
     %   if length(coef) >= 2
       %         for i = 2 : length(coef)
        %                mdlstring = [mdlstring  ' + ' num2str(coef(i), 2) ' (' x{i} ')']; 
          %      end
      %  end
     % print on the graph
      %  