% Do indiv1 dominates indiv2 in a distance-sense?
function boolean = crowdDominates(indiv1, indiv2)
    assert(isa(indiv1, 'individual'))
    assert(isa(indiv2, 'individual'))
    
    if (indiv1.rank < indiv2.rank) || ...
            ((indiv1.rank == indiv2.rank) && (indiv1.distance > indiv2.distance))
        boolean = true;
    else
        boolean = false;
    end
end

