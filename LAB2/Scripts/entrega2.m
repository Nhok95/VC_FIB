clc;
clear all;
Original = imread('Bird24b.bmp');
%Original = imread('TTGL.jpg');
I = rgb2gray(Original);
N = 256;
count = Nbins(N,I);
%count = Nbins2(N,I);

[JJ,binloc] =imhist(I,N);
figure;imhist(I,N);