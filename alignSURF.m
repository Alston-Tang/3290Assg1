function aimg = alignSURF(img,B)
% This function is to align img to B using single-scale algorithms
% Output is the aligned version of img
    aimg = zeros(size(img));
    dv = zeros(2, 1);
    
    pointsB = detectSURFFeatures(B);
    pointsImg = detectSURFFeatures(img);
    [f1, vpts1] = extractFeatures(B, pointsB);
    [f2, vpts2] = extractFeatures(img, pointsImg);
    indexPairs = matchFeatures(f1, f2) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
    difference = matchedPoints2.Location - matchedPoints1.Location;
    
    avgDiff = sum(difference) / size(difference, 1);
    xL = abs(avgDiff(1) * 5);
    yL = abs(avgDiff(2) * 5);
    count = 0;
    for i = 1:size(difference, 1)
        if abs(difference(i, 1) - avgDiff(1)) < xL && abs(difference(i, 2) - avgDiff(2)) < yL
            count = count + 1;
            dv(1) = dv(1) + difference(i, 1);
            dv(2) = dv(2) + difference(i, 2);
        end
    end
    dv = round(dv / count);
    
    tmp = dv(1);
    dv(1) = dv(2);
    dv(2) = tmp;
    
    
	
	% TODO2: Matching in single-scale
    for y = 1 : size(img, 1)
        for x = 1 : size(img, 2)
            adjY = y - dv(1);
            adjX = x - dv(2);
            if adjY > 0 && adjY <size(img, 1) && adjX > 0 && adjX < size(img, 2)
                aimg(adjY, adjX) = img(y, x);
            end
        end
    end
	% Output aimg
	
end


