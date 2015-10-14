function [aR, aG] = alignSURF(B, G, R)
% This function is to align img to B using single-scale algorithms
% Output is the aligned version of img

    factor = min([2000, 2000] ./ size(B));
    if (factor < 1)
        rB = imresize(B, factor);
        rG = imresize(G, factor);
        rR = imresize(R, factor);
    else
        rB = B;
        rG = G;
        rR = R;
        factor = 1;
    end
    
    pointsB = detectSURFFeatures(rB);
    pointsG = detectSURFFeatures(rG);
    pointsR = detectSURFFeatures(rR);
    [fB, vptsB] = extractFeatures(rB, pointsB);
    [fG, vptsG] = extractFeatures(rG, pointsG);
    [fR, vptsR] = extractFeatures(rR, pointsR);
    
    dvBG = round(alignSURFI(fB, vptsB, fG, vptsG) ./ factor);
    dvBR = round(alignSURFI(fB, vptsB, fR, vptsR) ./ factor);
    
    disp(dvBG);
    disp(dvBR);
	
	% TODO2: Matching in single-scale
    aG = circshift(G, dvBG);
    aR = circshift(R, dvBR);
	% Output aimg
end


