function dv = alignSURFI(fB, vptsB, fImg, vptsImg)
    indexPairs = matchFeatures(fB, fImg);
    matchedPointsB = vptsB(indexPairs(:, 1));
    matchedPointsImg = vptsImg(indexPairs(:, 2));
    difference = matchedPointsB.Location - matchedPointsImg.Location;
    
    
    dist = sqrt(difference(1, 1)^2 + difference(1, 2)^2);
    deg = abs(difference(1, 1)) / dist;
    
    possibleTot = [dist, deg, difference(1, 1), difference(1, 2)];
    possibleAvg = [dist, deg, difference(1, 1), difference(1, 2)];
    possibleCount = 1;
    
    for i = 2 : size(difference, 1)
        x = difference(i, 1);
        y = difference(i, 2);
        dist = sqrt(x^2 + y^2);
        deg = abs(x) / dist;
        
        for j = 1 : size(possibleAvg, 1)
            match = false;
            if abs(deg - possibleAvg(j, 2)) < 0.1 && abs(dist - possibleAvg(j, 1)) < 5
                possibleCount(j) = possibleCount(j) + 1;
                possibleTot(j, 1) = possibleTot(j, 1) + dist;
                possibleTot(j, 2) = possibleTot(j, 2) + deg;
                possibleTot(j, 3) = possibleTot(j, 3) + x;
                possibleTot(j, 4) = possibleTot(j, 4) + y;
                possibleAvg(j, 1) = possibleTot(j ,1) / possibleCount(j);
                possibleAvg(j, 2) = possibleTot(j ,2) / possibleCount(j);
                possibleAvg(j, 3) = possibleTot(j, 3) / possibleCount(j);
                possibleAvg(j, 4) = possibleTot(j, 4) / possibleCount(j);
                match = true;
                break;
            end
        end
        if  ~match
            possibleCount = [possibleCount; 1];
            possibleTot = [possibleTot; dist, deg, x, y];
            possibleAvg = [possibleAvg; dist, deg, x, y];         
        end
    end
    
    max = 0;
    maxIndex = 0;
    for i = 1 : size(possibleCount)
        if possibleCount(i) > max
            max = possibleCount(i);
            maxIndex = i;
        end
    end
    
    dv = round([possibleAvg(maxIndex, 4), possibleAvg(maxIndex, 3)]);
end
