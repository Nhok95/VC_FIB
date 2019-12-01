function [BW] = Local_binari(x, k)
    x = double(x);

    [s, n] = size(x);

    half = floor((s+1)/2);
    ng = x(half, :);
    
    mu = mean(x);
    sigma = std(x);

    BW = ng < (mu-sigma*0.2)-k;
end

