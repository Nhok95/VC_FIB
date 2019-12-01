function [scan] = myscanfiles()
    %a = dir('I:/vc/Short Project/*.eye');
    eyesDir = char(strcat(pwd, {'\BD\*.eye'}));
    a = dir(eyesDir);
    nf = size(a);
    %lx = zeros(nf);ly = zeros(nf);rx = zeros(nf);ry = zeros(nf);
    for i = 1:nf 
        filename = horzcat(a(i).folder,'/',a(i).name);
        fid = fopen(filename);
        s = textscan(fid, '%s', 1, 'delimiter', '\n');
        c = textscan(fid, '%d', 4, 'delimiter', ' ');
        scan(i).lx = c{1}(1);
        scan(i).ly = c{1}(2);
        scan(i).rx = c{1}(3);
        scan(i).ry = c{1}(4);
        fclose(fid);
    end
end

