

%% CSCI 3290: Assignment 1 Starter Code

% Input glass plate image
imgname = '00978u.tif';
try
    fullimg = imread(imgname);
catch
    imgSeries = strcat(imgname(1:3), '00');
    imgExt = imgname(size(imgname, 2)-2:size(imgname, 2));
    if strcmp('jpg', imgExt) == 1
        imgDir = 'service';
    else
        imgDir = 'master';
    end
    url = strcat('http://lcweb2.loc.gov/',imgDir,'/pnp/prok/', imgSeries, '/', imgname);
    websave(imgname, url);
    disp('Image Downloaded');
    fullimg = imread(imgname);
end

%fullimg = imread(imgname);

% Convert to double matrix
fullimg = im2double(fullimg);

% TODO1: Extract 3 channels from input image
% Calculate the height of each part (about 1/3 of total)
OriImgH = size(fullimg,1);
ImgH = floor(OriImgH/3);

% Separate B-G-R channels
B = fullimg(1:ImgH,:);
G = fullimg(ImgH+1:2*ImgH,:);
R = fullimg(2*ImgH+1:3*ImgH,:);



%% Align the images
% Functions that might be useful:"circshift", "sum", and "imresize"

tic;   % The Timer starts. To Evalute algorithms' efficiency.

% Write your codes here. 
% Write your function of alignSingle and alignMulti

% aG = alignMulti(G,B);
% aR = alignMulti(R,B);
[aR, aG] = alignSURF(B, G, R);
% aG = alignSingle(G,B);
% aR = alignSingle(R,B);

toc;   % The Timer stops and displays time elapsed.
%% Output Results
% Create a color image (3D array): "cat" command
% For your own code, "G","R" shoule be replaced to "aG","aR"
colorImg = cat(3,aR,aG,B);
tic;
[edgeb, edget, edgel, edger] = cropEdge(colorImg, 0.8);
cropColorImg = colorImg(edget:edgeb, edgel:edger, :);
toc;
% Show the resulting image: "imshow" command
imshow(cropColorImg);

% Save result image to File
% imwrite(colorImg,['result-' imgname]);

