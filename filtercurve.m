function filteredcurve = filtercurve(curve,threshold)
    filtered_values = curve(curve<=threshold);
    unfiltered_values = curve(curve>threshold);
    filteredcurve = [zeros(length(filtered_values),1); unfiltered_values];
end