function population = crowdingDistanceAssignment(population, objectives)
    assert(length(population) >= 1)

    popSize = length(population);
    for i=1:popSize; population(i).distance = 0; end
    
    for i=1:length(objectives)
        % Sort population, and get objective values
        [population, objectiveValues] = ...
            utils.sortfun(@(indiv) indiv.objectiveValues(i), population);
        
        % Set first and last individual 
        population(1).distance = inf;
        population(popSize).distance = inf;
        
        for j=2:popSize-1
            population(j).distance = population(j).distance + ...
                (objectiveValues(j+1) - objectiveValues(j-1)) / ...
                (objectives{i}.valMax - objectives{i}.valMin);
        end
    end
end