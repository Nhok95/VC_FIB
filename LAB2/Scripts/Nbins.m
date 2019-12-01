function MyHistogram = Nbins(N,I)
[x y] = size(I);
MyHistogram = zeros([N 1]); 
k = 256/N;

for i=1:x
    for j=1:y
        v = double(I(i,j));
        index = floor(v/k)+1;
        MyHistogram(index) = MyHistogram(index)+1;
    end
    bar(MyHistogram);
end

end

