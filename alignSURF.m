function [aR, aG] = alignSURF(B, G, R)
% This function is to align img to B using single-scale algorithms
% Output is the aligned version of img
    pointsB = detectSURFFeatures(B);
    pointsG = detectSURFFeatures(G);
    pointsR = detectSURFFeatures(R);
    [fB, vptsB] = extractFeatures(B, pointsB);
    [fG, vptsG] = extractFeatures(G, pointsG);
    [fR, vptsR] = extractFeatures(R, pointsR);
    
    dvBG = alignSURFI(fB, vptsB, fG, vptsG);
    dvBR = alignSURFI(fB, vptsB, fR, vptsR);
    
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


