clc;
clear all;

imgFiles = dir('*.jpg');   % get all jpg files in the folder 
numfiles = length(imgFiles);  % total number of files 
data = zeros(numfiles,4);
for k = 1:numfiles   % loop for each file 
    img = imgFiles(k).name;
    i1=imread(img);
    %figure, imshow(i1);
    i2=rgb2gray(i1);
    %figure, imshow(i2);
    upper = 230;
    lower = 230;
    i2(i2 >= upper) = 255;
    i2(i2 <= lower) = 0;
    bw1 = bwmorph(i2, 'clean');
    bw2=imcomplement(bw1);
    bw2=imfill(bw2,'holes'); 
    se= strel('disk',7);
    bw3=imopen(bw2,se);
    stats=regionprops(bw2,'Area','Eccentricity','Circularity','Extent');
    data(k,1)= stats(1).Area; data(k,2)= stats(1).Eccentricity; 
    data(k,3)= stats(1).Circularity; data(k,4)= stats(1).Extent;
    
end