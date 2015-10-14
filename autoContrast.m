function contrastImg = autoContrast(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    pixMax = max(max(max(img)));
    pixMin = min(min(min(img)));
    if pixMax < 1 || pixMin > 0
        img = (img - pixMin) / (pixMax - pixMin);
    end
    gray = sum(img, 3) ./ 3;
    gray(gray < 0.1) = -1;
    gray(gray > 0.9) = 1;
    gray(gray >= 0.1 & gray <= 0.9) = 0;
    img(:,:,1) = img(:,:,1) + gray;
    img(:,:,2) = img(:,:,2) + gray;
    img(:,:,3) = img(:,:,3) + gray;
    img(img < 0.1) = 0.1;
    img(img > 0.9) = 0.9;
    contrastImg = (img - 0.1) / 0.8;
end

