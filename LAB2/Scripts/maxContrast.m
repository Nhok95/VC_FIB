function Result = maxContrast(I)
G = rgb2gray(I);
[x,y] = size(G);
z = zeros(x,1);

ID = G(:,1:end-1); ID = [z ID];
K = G - ID; K = K(:,2:end); K = [z K];

[i j]= find (K == max(max(K)));

RGB = insertShape(I,'circle', [j i 15], 'LineWidth', 3, 'Color', 'blue');
Result = insertShape(G,'circle', [j i 3], 'LineWidth', 1, 'Color', 'red');

subplot(1,2,2);imshow(RGB);
subplot(1,2,1);imshow(Result);
end

