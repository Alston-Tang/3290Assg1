function aimg = alignSingle(img,B)
% This function is to align img to B using single-scale algorithms
% Output is the aligned version of img
    
    aimg = zeros(size(img));
	[h,w] = size(B);
    [hImg, wImg] = size(img);
    %{
	% TODO: Write your codes for single-scale implementation
	% Initialize variables
	minMetric = inf; % minimum metric value
    maxCorrelation = -1;
	minVector = zeros(2,1); % best shift vector by far
    
    crosscorr = normxcorr2(B, img);
    for y = 1 : size(crosscorr, 1)
        for x = 1 : size(crosscorr, 2)
            if maxCorrelation < crosscorr(y, x)
                maxCorrelation = crosscorr(y, x);
                minVector(1) = y - size(B, 1);
                minVector(2) = x - size(B, 2);
            end
        end
    end
    %}
    dv = weighDifference(B, img, -10, 10, 10, -10);  
	
	% TODO2: Matching in single-scale
    aimg = circshift(img, -dv);
	% Output aimg
	
end


