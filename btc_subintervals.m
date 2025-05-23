close all
clear all

% Define cutoff date
cutoffDate = datetime('09/07/2016', 'InputFormat', 'dd/MM/yyyy');


% Read the dataset
data = readtable('btcpricehistory.csv'); 
data = data(data.Date <= cutoffDate, :);
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
years_ahead = 13;
xfit = 1:fitlength+years_ahead*365;

% Filter for values > 0
fitcurve = fitted_curve(xfit);
fitcurve_old = filtercurve(fitcurve,0);

% Get prediction bounds
[bounds, delta] = predint(fitted_curve, x, 0.90, 'observation');
bounds = fitpredictionbounds(bounds,x,xfit);
bound1_old = bounds(:,1);
bound2_old = bounds(:,2);

save("fit2016.mat","fitcurve_old","bound1_old","bound2_old")

% plots