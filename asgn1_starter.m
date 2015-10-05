%% CSCI 3290: Assignment 1 Starter Code

% Input glass plate image
imgname = '01087v.jpg';
fullimg = imread(imgname);

% Convert to double matrix
fullimg = im2double(fullimg);

% TODO1: Extract 3 channels from input image
% Calculate the height of each part (about 1/3 of total)
OriImgH = size(fullimg,1);
ImgH = floor(OriImgH/3);

% Separate B-G-R channels
B = fullimg(1:ImgH,:);
G = fullimg(ImgH+1:2*ImgH,:);
R = fullimg(2*ImgH+1:OriImgH,:);



%% Align the images
% Functions that might be useful:"circshift", "sum", and "imresize"

tic;   % The Timer starts. To Evalute algorithms' efficiency.

% Write your codes here. 
% Write your function of alignSingle and alignMulti

% aG = alignSingle(G,B);
% aR = alignSingle(R,B);
% aG = alignMulti(G,B);
% aR = alignMulti(R,B);
aG = alignSURF(G, B);
aR = alignSURF(R, B);

toc;   % The Timer stops and displays time elapsed.

%% Output Results
minHeight = size(B, 1);
if size(aG, 1) < minHeight
    minHeight = size(aG, 1);
end
if size(aR, 1) < minHeight
    minHeight = size(aR, 1);
end
aG = aG(1:minHeight, :);
aR = aR(1:minHeight, :);
B = B(1:minHeight, :);
% Create a color image (3D array): "cat" command
% For your own code, "G","R" shoule be replaced to "aG","aR"
colorImg = cat(3,aR,aG,B);

% Show the resulting image: "imshow" command
imshow(colorImg);

% Save result image to File
% imwrite(colorImg,['result-' imgname]);

