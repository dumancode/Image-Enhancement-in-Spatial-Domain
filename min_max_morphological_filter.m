%% Min-max morphological filtering
% NOTE -> For convolution I chose PIXEL REPLICATION METHOD FOR PADDING,
% because, To better learn pixel manipulations and copying in image processing,
% I wanted to use this method. Zero Padding is a straightforward procedure. 
% First, I placed the original image into the new image. Then,
% I copied the top row of the original image to the new image. 
% After that, I copied the bottom row of the original image to the new image. 
% Next, I copied the leftmost column of the original image to the new image,
% and finally, I copied the rightmost edge of the original image to the new image. 
% This way, I completed the padding process.
clc; clear;

inputImage = imread('morphology_input.png'); %Reading Image

neighborhoodSize = 1; % For convolution, I want to select 3x3 area.
% So, my neighborhoodSize is 1. This means that, when I travels to my
% inputImage  I select  9 pixel intensities.

% Get the size of the image
[m, n] = size(inputImage);

% For paddingImage image : I  choose  PIXEL REPLICATION FOR PADDING
% rather than   zero padding.
paddingImage(2:m+1, 2:n+2-1) = inputImage(:,:); %This line copies the content of the image2 to
% the center of the paddingImage. It essentially creates a copy of image2 within the interior
% of paddingImage. The dimensions of paddingImage are larger by two rows and two columns, 
% and this operation places inputImage inside it.

paddingImage(1,2:n+1) = inputImage(1,:); %This line assigns the first row of inputImage to
% the top row of paddingImage. It's filling the top border of paddingImage with the 
% values from the first row of inputImage.

paddingImage(m+2,2:n+1) = inputImage(m,:); %This line assigns the last row of inputImage
% to the bottom row of paddingImage. It's filling the bottom border of paddingImage with
% the values from the last row of inputImage.

paddingImage(:,1) = paddingImage(:,2); %This line copies the values from the second column 
% of paddingImage to the entire leftmost column of paddingImage. It replicates the values
% from the second column to fill the left border of paddingImage.

paddingImage(:,n+2) = paddingImage(:,n+1); %This line copies the values from the second-to-last
% column of paddingImage to the entire rightmost column of paddingImage.
% It replicates the values from the second-to-last column to fill the right border of paddingImage.


maxFilteredImage = uint8(zeros(m, n));

% Now this code is performing a maximum filter operation, where for each pixel in paddingImage, 
% it calculates the maximum intensity value in a local neighborhood.
% (I found the maximum filter operation in the course's slidess)
% The result is stored in maxFilteredImage, which represents the maximum-filtered version of the image. 
for i = 2 : m+1
    for j = 2 : n+1
        
        neighborhood = paddingImage(i-neighborhoodSize:i+neighborhoodSize, j-neighborhoodSize:j+neighborhoodSize);
        

        neighborhoodElements = max(neighborhood(:)); %The code calculates the maximum
        % intensity value within the neighborhood using the max function
        maxFilteredImage(i-1, j-1) = neighborhoodElements; % The location (i-1, j-1) in maxFilteredImage
        % is updated with the maximum intensity value.

    end
end
%When I applied the max filter, I observed that some of the black points in the center disappeared.
% As shown in the slides, I thought that applying the min filter to the output could potentially 
% bring back some of the lost black points. Therefore, I applied the min filter to the output image,
% but before doing that, I need to perform the padding operation.

%Again, pixel multiplication method for padding. I explained this method above.
paddingImage2 = uint8(zeros(m+2, n+2));
paddingImage2(2:m+1, 2:n+2-1) = maxFilteredImage(:,:);
paddingImage2(1,2:n+1) = maxFilteredImage(1,:);
paddingImage2(m+2,2:n+1) = maxFilteredImage(m,:);
paddingImage2(:,1) = paddingImage2(:,2);
paddingImage2(:,n+2) = paddingImage2(:,n+1);

minMaxFilteredImage =uint8(zeros(m, n));
for i = 2 : m+1
    for j = 2 : n+1
        
        % Define the neighborhood region
        neighborhood = paddingImage2(i-neighborhoodSize:i+neighborhoodSize, j-neighborhoodSize:j+neighborhoodSize);
        

        neighborhoodElements = min(neighborhood(:)); % min fitering
        minMaxFilteredImage(i-1, j-1) = neighborhoodElements;

    end
end

subplot(1,2,1)
imshow(inputImage)
title("morphology_input.png")
subplot(1,2,2)

imshow(minMaxFilteredImage)
title("min_max_filtered_output.png")
