function [centrX, centrY] = getCentroideCentral(centroids)
    centroidsX = centroids(:,1);
    c1 = centroidsX(centroidsX>=0);
    centroidsY = centroids(:,2);
    c2 = centroidsY(centroidsY>=0);
    centrX = mean(c1);
    centrY = mean(c2);
end
