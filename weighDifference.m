function dv = weighDifference(B, img, l, r, t, b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % cropImg = zeros(size(img));
    errorMin = realmax;
    [h, w] = size(img);
    for dvy = b : t
        for dvx = l : r
            Bb = -dvy + 1;
            Bl = dvx + 1;
            Bt = h - dvy;
            Br = w + dvx;
            if Bb < 1 Bb = 1; end
            if Bl < 1 Bl = 1; end
            if Bt > h Bt = h; end
            if Br > w Br = w; end
            
            % adjImg = circshift(img, [dvy, dvx]);
            errorMatrix = abs(B(Bb:Bt,Bl:Br)-img(h-Bt+1:h-Bb+1,w-Br+1:w-Bl+1));
            error = sum(sum(errorMatrix))/(Bt-Bb+1)/(Br-Bl+1);
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

