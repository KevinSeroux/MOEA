function population = generateEvaluatedParetoFront(variables, objectives)
    count = length(variables);
    population(count) = individual;
    
    for i=1:count
        population(i).variables = variables(i,:);
    end
    
    population = evaluate(population, objectives);
end
