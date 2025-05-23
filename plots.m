% Plot prices
plot(data.Date,prices,'LineWidth', 1.2)
hold on

% Re-label axes to match log scale
realTicks = [10 100 1000 10000 100000 1000000];
logTicks = log10(realTicks);
yticks(logTicks);
yticklabels(string(realTicks/1000)+'K $');
ylim([0 log10(1100000)])

title("BTC Price History Log Chart")
grid

plot(fitcurve,'r','LineWidth',1.2)
plot(bounds, 'r--','LineWidth',1.2);

xline(datetime('28/11/2012', 'InputFormat', 'dd/MM/yyyy'), 'k--', 'I Halving','LabelVerticalAlignment', 'bottom');
xline(datetime('09/07/2016', 'InputFormat', 'dd/MM/yyyy'), 'k--', 'II Halving','LabelVerticalAlignment', 'bottom');
xline(datetime('11/10/2020', 'InputFormat', 'dd/MM/yyyy'), 'k--', 'III Halving','LabelVerticalAlignment', 'bottom');
xline(datetime('20/04/2024', 'InputFormat', 'dd/MM/yyyy'), 'k--', 'IV Halving','LabelVerticalAlignment', 'bottom');
xline(datetime('27/03/2028', 'InputFormat', 'dd/MM/yyyy'), 'k--', 'V Halving','LabelVerticalAlignment', 'bottom');


legend("BTC Price","Fit curve","Prediction Bounds (90%)","","","","","")


figure
% Get fit curves of previous halvings
load("fit2016.mat")
fitcurve_old = fitcurve_old(1:length(fitcurve));
bound1_old = bound1_old(1:length(fitcurve));
bound2_old = bound2_old(1:length(fitcurve));

plot(data.Date,prices,'LineWidth', 1.2)
hold on
plot(fitcurve_old,'r')
plot(bound1_old,'r--')
plot(bound2_old,'r--')
xline(datetime('09/07/2016', 'InputFormat', 'dd/MM/yyyy'), 'k--', 'II Halving','LabelVerticalAlignment', 'bottom');
legend("Current BTC Price","Fit Curve until II Halving (2016)","Prediction Bounds until II Halving (2016)")

 
% Re-label axes to match log scale
realTicks = [10 100 1000 10000 100000 1000000];
logTicks = log10(realTicks);
yticks(logTicks);
yticklabels(string(realTicks/1000)+'K $');
ylim([0 log10(1100000)])
title("Comparison with the previous Fit Curve")
grid