%Furkan Duman 2453173
 clc; clear;
%Read Image1.png
image1 = imread("Image1.png");

%Find its rows and columns
[rows, cols] = size(image1);

% For histogram diagram we cannot use "imhist", 
% So I have decided to create a 256-element matris. 
% I will scan all the pixels of Image1 and count how many of each pixel 
% value there are, and then I will store this information in my array. 
% In a way, I am creating a copy of the histeq function using a for loop.


histogramOfImage1 = zeros(1, 256); 
for row = 1:rows
    for col = 1:cols
        pixelOfOriginalImage = image1(row, col) +1; 
        histogramOfImage1(pixelOfOriginalImage) = histogramOfImage1(pixelOfOriginalImage) + 1;
    end
end
subplot(1,2,1)  % 1 row, 2 column  -> First Column
imshow(image1); %Show Image1
title("Image1.png")

subplot(1,2,2)   % -> Second Column

bar(0:255,histogramOfImage1); % For creating histogram plot I use bar function.
title('Histogram of original image'); % Title of bar function
xlabel('Pixel value');
ylabel('Number of pixels');

Image1Output = image1;
            
% I find the threshold value from the histogram.
% My threshold value is 169. So first, 
% I select  pixel values between 169 and 255.
selected_pixels = (Image1Output >= 169) & (Image1Output <= 255);

% Then I turn the pixels into white.
Image1Output(selected_pixels) = 255;
%Finally I turn pixels outside the brightness range into black.
Image1Output(~selected_pixels) = 0;


% Now, I save the Image1Output image to my computer.
imwrite(Image1Output, 'Image1Output.png');


 figure() % Create a new figure
 subplot(1,2,1) % 1 row, 2 column  -> First Column
 imshow(Image1Output); %Show Image1output
 title("Image1Output.png")
 subplot(1,2,2) % -> Second column

histogramOfImage1Output = zeros(1, 256); %Create a array for histogram of output.
%Again I  scan all pixels, and 
for row = 1:rows
    for col = 1:cols
        pixelOfImage1Output = Image1Output(row, col) +1; 
        histogramOfImage1Output(pixelOfImage1Output) = histogramOfImage1Output(pixelOfImage1Output) + 1;
    end
end


bar(0:255,histogramOfImage1Output); % For creating histogram plot I use bar function.
% 0:255 -> For X value, "histogram" array 
title('Histogram of new image');
xlabel('Pixel value');
ylabel('Number of pixels');


















