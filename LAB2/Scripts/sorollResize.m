function SNR = sorollResize(I)
G = rgb2gray(I);

imSize = size(G);

J = imresize(G,imSize*3/7);
J = imresize(J,imSize);

%mean
mu = mean(mean(G)); 

%standard deviation
sigma = std(std(double(G-J))); 

SNR = 10*log10(mu/sigma);
end

