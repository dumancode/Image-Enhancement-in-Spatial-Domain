%Furkan Duman 2453173

% NOTE -> For convolution I choice PIXEL REPLICATION METHOD FOR PADDING,
% because, To better learn pixel manipulations and copying in image processing,
% I wanted to use this method. Zero Padding is a straightforward procedure. 
% First, I placed the original image into the new image. Then,
% I copied the top row of the original image to the new image. 
% After that, I copied the bottom row of the original image to the new image. 
% Next, I copied the leftmost column of the original image to the new image,
% and finally, I copied the rightmost edge of the original image to the new image. 
% This way, I completed the padding process.


clc; clear;

%Read Image2.png
image2 = imread('image2.png');

% For remove the noise I use MEDIAN FILTER. So first I need Convolution.

% For convolution, I want to select 3x3 area.
% So, my neighborhoodSize is 1. This means that, when I travels to my image2
% I select  9 pixes intenity.  Then arrange the 9 pixels intensity 
% in ascending and descending order.Then select the median from this  nine
% values.  Then I place this value at candidate pixel.

neighborhoodSize = 1;  

% Get the size of the image
[m, n] = size(image2);


% For padding image : I  choose  PIXEL REPLICATION FOR PADDING
% rather than   zero padding.

%Creating a new image. (Extra 2 colums and 2 row then image2)  
paddingImage = uint8(zeros(m+2, n+2));

 
paddingImage(2:m+1, 2:n+2-1) = image2(:,:); %It essentially copies the content of image2
% into the center of paddingImage.


paddingImage(1,2:n+1) = image2(1,:); % This line assigns the first row of image2 to 
% the top row of paddingImage It's filling the top border of paddingImage with the values 
% from the first row of image2. 
paddingImage(m+2,2:n+1) = image2(m,:); %This line assigns the last row of image2 to the bottom row of paddingImage.
% It's filling the bottom border of paddingImage with the values from the last row of image2

paddingImage(:,1) = paddingImage(:,2); %This line assigns the second column of 
% paddingImage to the leftmost column of paddingImage. It's filling the left border of paddingImage with the values
% from the second column of paddingImage.
paddingImage(:,n+2) = paddingImage(:,n+1); % This line assigns the second-to-last column of 
% paddingImage to the rightmost column of paddingImage. 
% It's filling the right border of paddingImage with
% the values from the second-to-last column of denoisedImage.

% Create a matrix for edge detection.
edgeImage = uint8(zeros(m,n));

% I found these matrixes on lecture's slayt (week 3 page 65)
horizontalSobel = [-1,-2,-1; 0,0,0; 1,2,1];
verticalSobel =   [-1,0,1; -2,0,2; -1,0,1];

% Perform Sobel edge detection for original image.
% size of paddingImage is [m+2,n+2], So for rows : I start 2 and finish
% m+1, for column: I start to 2 and finish to n+1.
for i = 2:m+1
    for j = 2:n+1
        
        totalH = 0;
        totalV = 0;
        % For example If  the selected pixels  centered around the pixel 
        % at position (i, j) : I extracts a 3x3 neighborhood of pixels from the 
        % paddingImage.  (i-1,i,i+1:j-1,j,j+1)
        neighborhood = double(paddingImage(i-1:i+1,j-1:j+1));

        [x,y] = size(neighborhood);
        % Sobel operator.  The horizontal and vertical Sobel operators are used to perform these calculations.
        for o = 1:x
            for f = 1:y
                totalH = totalH + (neighborhood(o,f) * verticalSobel(o,f));
                totalV = totalV + (neighborhood(o,f) * horizontalSobel(o,f));



            end
        end 
        edgeImage(i-1,j-1) =  (totalH) + (totalV);
       
    end
end

Image2Output = uint8(zeros(m,n));
% Performing median filtering on an image using a 3x3 neighborhood
% Note: The original image is "Salt and Pepper" noise.

for i = 1+neighborhoodSize : m+1 %For modularity, I don't write "1" to neighborhoodSize
    for j = 1+neighborhoodSize : n+1
        
        % The neighborhood variable contains the pixel values of this 3x3 region.
        neighborhood = paddingImage(i-neighborhoodSize:i+neighborhoodSize, j-neighborhoodSize:j+neighborhoodSize);
        
        % I flattens the neighborhood into a 1D array
        neighborhoodElements = neighborhood(:);
        % Then I sort  in ascending order
        sortedVec = sort(neighborhoodElements);

        % I calculate  the index corresponding to the middle value of the sorted array
        midElementIndex = round(length(sortedVec) / 2);

        %Finally, The median value calculated for the 3x3 neighborhood is assigned to the output image 
        Image2Output(i-1, j-1) = sortedVec(midElementIndex);


    end
end



% similar image padding operation (PIXEL REPLICATION METHOD) 

paddingImage2 = uint8(zeros(m+2, n+2));
paddingImage2(2:m+1, 2:n+1) = Image2Output(:,:); % This line copies the content 
% of the Image2Output to the center of paddingImage2, effectively filling the 
% inner part of paddingImage2 with the values from 
paddingImage2(1,2:n+1) = Image2Output(1,:); %This line assigns the first row of 
% Image2Output to the top row of paddingImage2, effectively filling the top border of 
% paddingImage2 with the values from the first row of Image2Output.

paddingImage2(m+2,2:n+1) = Image2Output(m,:); %This line assigns the last row of 
% Image2Output to the bottom row of paddingImage2, effectively filling the bottom border
% of paddingImage2 with the values from the last row of Image2Output.

paddingImage2(:,1) = paddingImage2(:,2); % This line fills the left border of paddingImage2
% with the values from the second column of paddingImage2. It essentially replicates the second column's 
% values to the entire left border.

paddingImage2(:,n+2) = paddingImage2(:,n+1); %This line fills the right border of paddingImage2
% with the values from the second-to-last column of paddingImage2. It replicates the values from 
% the second-to-last column to the entire right border.




edgeImageForOutput = uint8(zeros(m,n)); % % Create a matrix for edge detection.
 
% Perform Sobel edge detection for output image.
% I explained above how this function works.
% Exactly the same logic works.
for i = 2:m+1
    for j = 2:n+1
        
        totalH = 0;
        totalV = 0;

        neighborhood = double(paddingImage2(i-1:i+1,j-1:j+1));
        [x,y] = size(neighborhood);

        for o = 1:x
            for f = 1:y
                totalH = totalH + (neighborhood(o,f) * verticalSobel(o,f));
                totalV = totalV + (neighborhood(o,f) * horizontalSobel(o,f));



            end
        end 
        edgeImageForOutput(i-1,j-1) =  (totalH) + (totalV);
       
    end
end


% For display ;

subplot(2,2,1)   % Create 2 rows, 2 columns (1-2-3-4)
imshow(image2) 
title("Image2.png")
subplot(2,2,2)
imshow(uint8(edgeImage))
title("Image2 Edge Map")
subplot(2,2,3)
imshow(Image2Output)
title("Image2Output.png")

subplot(2,2,4)
imshow(uint8(edgeImageForOutput))   
title("Image2Output Edge Map ")