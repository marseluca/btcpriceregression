function prediction_bounds = fitpredictionbounds(bounds,x,xfit)
    % Fit del bound inferiore
    ft_bounds = fittype('a*log10(x)+b', 'independent', 'x');
    opts_bounds = fitoptions('Method', 'NonlinearLeastSquares', 'Robust', 'Bisquare');
    
    [fit_low, ~]  = fit(x, bounds(:,1), ft_bounds, opts_bounds);
    [fit_high, ~] = fit(x, bounds(:,2), ft_bounds, opts_bounds);
    
    prediction_bounds = [fit_low(xfit), fit_high(xfit)];
end