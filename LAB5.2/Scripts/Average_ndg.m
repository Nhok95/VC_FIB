function [av] = Average_ndg(histogram)
    total = sum(histogram);
    av = 0;
    for i = 1:256
        prob = histogram(i)/total;
        av  = av + prob*(i-1);
    end
end

