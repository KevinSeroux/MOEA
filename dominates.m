% Do indiv1 dominates indiv2 according to objective values and not the
% rank?
function boolean = dominates(indiv1, indiv2)
    assert(isa(indiv1, 'individual'))
    assert(isa(indiv2, 'individual'))
    assert(length(indiv1.objectiveValues) >= 1)
    assert(length(indiv1.objectiveValues) == length(indiv2.objectiveValues))
    
    countObjectives = length(indiv1.objectiveValues);
    isDominatingAtLeast1Time = false; % 1 domination is one of the requirements
    
    % For indiv1 to dominate indiv2, all the objective values must be lower
    for i=1:countObjectives
        objIndiv1 = indiv1.objectiveValues(i);
        objIndiv2 = indiv2.objectiveValues(i);
        
        if objIndiv1 > objIndiv2
            boolean = false;
            return % Shortcut to exit the function
            
        elseif objIndiv1 < objIndiv2
            isDominatingAtLeast1Time = true;
            
        end
    end
    
    if isDominatingAtLeast1Time
        boolean = true;
    else
        boolean = false;
    end
end

