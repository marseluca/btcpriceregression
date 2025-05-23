close all
clear all

% Read the dataset
data = readtable('btcpricehistory.csv'); 
data.Price = strrep(data.Price, ',', '');
data.Price = str2double(data.Price);  % ora è una colonna numerica
data = flipud(data);

% Get prices
prices = log10(data.Price);

%% Fit
x = (1:height(data))'; 
ft = fittype('a*log10(x)+b', 'independent', 'x');
opts = fitoptions('Method', 'NonlinearLeastSquares', 'Robust', 'Bisquare');
[fitted_curve, gof] = fit(x, prices, ft, opts);  % <-- fit robusto con bisquare

% Predict for "years_ahead" years
fitlength = length(data.Price);
years_ahead = 4;
xfit = 1:fitlength+years_ahead*365;

% Filter for values > 0
fitcurve = fitted_curve(xfit);
fitcurve = filtercurve(fitcurve,0);

% Get prediction bounds
[bounds, delta] = predint(fitted_curve, x, 0.90, 'observation');
bounds = fitpredictionbounds(bounds,x,xfit);

plots