function dist = distance(indiv1, indiv2)
    p1 = indiv1.objectiveValues;
    p2 = indiv2.objectiveValues;
    
    dist = sqrt(sum((p2-p1).^2));
end

