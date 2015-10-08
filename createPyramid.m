function [pyramid, pSize] = createPyramid(img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

pyramid = cell(1, 10);
pyramid{1} = img;

MINX = 600;
MINY = 400;

y = size(img, 1);
x = size(img, 2);

pSize = 1;
subImg = img;
while y > MINY && x > MINX
    pSize = pSize + 1;
    subImg = imresize(subImg, 0.5);
    pyramid{pSize} = subImg;
    y = size(subImg, 1);
    x = size(subImg, 2);
end




end

