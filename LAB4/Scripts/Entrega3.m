%Binarització local
I = imread('Enters manuscrits 1.jpg');
Indg = rgb2gray(I);

X = 6;
Y = 3;

B = colfilt(Indg,[X Y],'sliding',@Local_binari, 4);

imshow(B);