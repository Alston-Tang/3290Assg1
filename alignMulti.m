function aimg = alignMulti(img,B)
% This function is to align img to B using multi-scale algorithms
% Output is the aligned version of img
	[h,w] = size(B);
	% TODO: Write your codes for multi-scale implementation
	% TODO: Build Image Pyramid for img & B
	pyramid_scale = 2;
	pyramid_levels = ; % choose your value
	gaussianf = fspecial('gaussian', [5,5], 1.5); % change if you need
	
	imgs = cell(pyramid_levels,1);
	imgs{1} = img;
	Bs = cell(pyramid_levels,1);
	Bs{1} = B;
	
	for ilevel = 2:1:pyramid_levels
		% write your code
		
	end
	
	% TODO3: Match using Image Pyramids
	for ilevel = pyramid_levels:-1:1
		
	end
	
	% Output aimg
	
end


