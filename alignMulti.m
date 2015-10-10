function aimg = alignMulti(img,B)
% This function is to align img to B using multi-scale algorithms
% Output is the aligned version of img
	[h,w] = size(B);
	% TODO: Write your codes for multi-scale implementation
	% TODO: Build Image Pyramid for img & B
    [BP, sizeBP] = createPyramid(B);
    [imgP, sizeImgP] = createPyramid(img);
    
    subDv = weighDifference(BP{sizeBP}, imgP{sizeImgP}, -20, 20, 20, -20);
    for indexP = sizeBP-1:-1:1
        subDv = subDv * 2;
        subDv = weighDifference(BP{indexP}, imgP{indexP}, subDv(2)-3, subDv(2)+3, subDv(1)+3, subDv(1)-3);
    end
    dv = subDv;
    
	
	% TODO3: Match using Image Pyramids
	aimg = circshift(img, -dv);
	
	% Output aimg
	
end


