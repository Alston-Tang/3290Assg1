function [edgeb, edget, edgel, edger] = cropEdge(img, thold)
    
    imgEdge = edge(img, 'canny', 0.2);
    [h, w] = size(imgEdge);
    edgeb = h;
    edget = 1;
    edgel = 1;
    edger = w;
    extend = w/100;
    for i = 1 : min(floor(h/8), h-4) 
        line = imgEdge(i:floor(i+extend), :);
        line = sum(line);
        line = mod(line, 2);
        count = sum(line);
        if count > w * thold
            edget = i + 3;
        end
    end
    
    for i = h : -1 : max(floor(h-h/8), 5) 
        line = imgEdge(floor(i-extend):i, :);
        line = sum(line);
        line = mod(line, 2);
        count = sum(line);
        if count > w * thold
            edgeb = i - 3;
        end
    end
    
    for i = 1 : min(floor(w/8), w-4) 
        line = imgEdge(:, i:floor(i+extend));
        line = sum(line, 2);
        line = mod(line, 2);
        count = sum(line);
        if count > h * thold
            edgel = i + 3;
        end
    end
    
    for i = w : -1 : max(floor(w-w/8), 5) 
        line = imgEdge(:, floor(i-extend):i);
        line = sum(line, 2);
        line = mod(line, 2);
        count = sum(line);
        if count > h * thold
            edger = i - 3;
        end
    end
end

