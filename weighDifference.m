function dv = weighDifference(B, img, l, r, t, b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % cropImg = zeros(size(img));
    errorMin = realmax;
    [h, w] = size(img);
    cropBase = zeros(3*h-2, 3*w-2);
    cropBase(h:2*h-1,w:2*w-1) = img(:,:);
    for dvy = b : t
        for dvx = l : r
            cropImg = cropBase(h+dvy:2*h+dvy-1,w+dvx:2*w+dvx-1);
            error = sum(sum((B-cropImg).^2));
            if error < errorMin
                errorMin = error;
                dv = [dvy, dvx];
            end
        end
    end
    disp(dv);
            
    
    
    
    %{
    for dvy = b : t
        disp(dvy);
        if dvy >= 0
            cropt = dvy + 1;
            cropb = size(img, 1);
            pastet = 1;
            pasteb = size(img, 1) - dvy;
        else
            cropt = 1;
            cropb = size(img, 1) + dvy;
            pastet = -dvy + 1;
            pasteb = size(img, 1);
        end
        for dvx = l : r
            if dvx>= 0
                cropl = 1;
                cropr = size(img, 2) - dvx;
                pastel = dvx + 1;
                paster = size(img, 2);
            else
                cropl = -dvx + 1;
                cropr = size(img, 2);
                pastel = 1;
                paster = size(img, 2) + dvx;
            end
            cropImg(:,:) = 0;
            cropImg(pastet:pasteb,pastel:paster) = img(cropt:cropb,cropl:cropr);
            error = sum(sum((cropImg - B).^2));
            if error < errorMin
                errorMin = error;
                dv = [dvy, dvx];
            end
        end
    end
    %}
end

