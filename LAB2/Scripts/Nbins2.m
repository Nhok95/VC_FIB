function MyHistogram = Nbins2(N,I)
[x y] = size(I);
MyHistogram = zeros([N 1]); 
k = 256/N;

for i=1:x
    for j=1:y
        v = double(I(i,j));
        for index=1:N
            if v <= k*index
                MyHistogram(index) = MyHistogram(index)+1;
                break;
            end
        end    
    end
    bar(MyHistogram);
end

end
