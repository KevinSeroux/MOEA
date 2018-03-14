function population = evaluate(population, objectives)
    popSize = length(population);
    countObjectives = length(objectives);
    
    for i=1:popSize
        population(i).objectiveValues = inf(1, countObjectives);
        
        for j=1:countObjectives
            population(i).objectiveValues(j) = ...
                objectives{j}.get(population(i).variables);
        end
    end
end