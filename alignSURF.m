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
    aG = zeros(size(G));
    aR = zeros(size(R));
    for y = 1 : size(B, 1)
        for x = 1 : size(B, 2)
            adjGY = y + dvBG(1);
            adjGX = x + dvBG(2);
            adjRY = y + dvBR(1);
            adjRX = x + dvBR(2);
            if adjGY > 0 && adjGY <size(G, 1) && adjGX > 0 && adjGX < size(G, 2)
                aG(adjGY, adjGX) = G(y, x);
            end
            if adjRY > 0 && adjRY <size(R, 1) && adjRX > 0 && adjRX < size(R, 2)
                aR(adjRY, adjRX) = R(y, x);
            end
        end
    end
	% Output aimg
end


