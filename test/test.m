imgFiles = dir('*.jpg');   % get all jpg files in the folder 
numfiles = length(imgFiles);  % total number of files 
datat = zeros(numfiles,5);
typet = zeros(numfiles);
for k = 1:numfiles   % loop for each file 
    img = imgFiles(k).name;
    i1=imread(img);
    i2=rgb2gray(i1);
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
    area=stats(1).Area;
    eccen=stats(1).Eccentricity;
    circu=stats(1).Circularity;
    ext=stats(1).Extent;
    datat(k,1)= stats(1).Area; datat(k,2)= stats(1).Eccentricity; 
    datat(k,3)= stats(1).Circularity; datat(k,4)= stats(1).Extent;
    if eccen>=0.956
        if circu>=0.219
            figure,imshow(i1);
            title('Classified as CRICKET BAT');
            datat(k,5)=1;
            typet(k ) = 1;
        else
            if circu>=0.0626
            figure,imshow(i1);
            title('Classified as ICE HOCKEY STICK');
            datat(k,5)=2;
            typet(k) = 2;
            else
                figure,imshow(i1);
                title('Classified as FENCING SWORD');
                datat(k,5)=3;
                typet(k) = 3;
            end
        end
    else 
        if circu>=0.5186
            figure,imshow(i1);
            title('Classified as TABLE TENNIS PADDLE');
            datat(k,5)=4;
            typet(k) = 4;
        else
            figure,imshow(i1);
            title('Classified as LAWN TENNIS BAT');
            datat(k,5)=5;
            typet(k) = 5;
        end
    end
end    
                
        
            
        
            
    