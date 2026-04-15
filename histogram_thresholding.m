%% Histogram-based thresholding and binary enhancement
 clc; clear;
%Read threshold_input.png
inputImage = imread("threshold_input.png");

%Find its rows and columns
[rows, cols] = size(inputImage);

% For histogram diagram we cannot use "imhist", 
% So I have decided to create a 256-element matrix. 
% I will scan all the pixels of Image1 and count how many of each pixel 
% value there are, and then I will store this information in my array. 
% In a way, I am creating a copy of the histeq function using a for loop.


histogramOfInput = zeros(1, 256); 
for row = 1:rows
    for col = 1:cols
        inputPixel = inputImage(row, col) +1; 
        histogramOfInput(inputPixel) = histogramOfInput(inputPixel) + 1;
    end
end
subplot(1,2,1)  % 1 row, 2 column  -> First Column
imshow(inputImage); %Show Image1
title("threshold_input.png")

subplot(1,2,2)   % -> Second Column

bar(0:255,histogramOfInput); % For creating histogram plot I use bar function.
title('Histogram of original image'); % Title of bar function
xlabel('Pixel value');
ylabel('Number of pixels');

binaryOutput = inputImage;
            
% I find the threshold value from the histogram.
% My threshold value is 169. So first, 
% I select  pixel values between 169 and 255.
selected_pixels = (binaryOutput >= 169) & (binaryOutput <= 255);

% Then I turn the pixels into white.
binaryOutput(selected_pixels) = 255;
%Finally I turn pixels outside the brightness range into black.
binaryOutput(~selected_pixels) = 0;


% Now, I save the binaryOutput image to my computer.
imwrite(binaryOutput, 'threshold_binary_output.png');


 figure() % Create a new figure
 subplot(1,2,1) % 1 row, 2 column  -> First Column
 imshow(binaryOutput); %Show Image1output
 title("threshold_binary_output.png")
 subplot(1,2,2) % -> Second column

histogramOfbinaryOutput = zeros(1, 256); %Create a array for histogram of output.
%Again I  scan all pixels, and 
for row = 1:rows
    for col = 1:cols
        pixelOfbinaryOutput = binaryOutput(row, col) +1; 
        histogramOfbinaryOutput(pixelOfbinaryOutput) = histogramOfbinaryOutput(pixelOfbinaryOutput) + 1;
    end
end


bar(0:255,histogramOfbinaryOutput); % For creating histogram plot I use bar function.
% 0:255 -> For X value, "histogram" array 
title('Histogram of new image');
xlabel('Pixel value');
ylabel('Number of pixels');


















