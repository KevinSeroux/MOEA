function population = geneticAlgorithm(config)
    display = config.display;
    objectives = config.objectives;
    popSize = config.popSize;
    
    parents = [];
    children = generatePopulation(config); % First generation
    
    while 1
        children = evaluate(children, objectives);
        population = [parents, children];
        fronts = fastNonDeterminatedSort(population);
        
        % User feedback
        for i=1:length(display); display{i}.print(fronts{1}); end
        
        parents = [];
        i = 1;
        
        while i < length(fronts) && length(parents) + length(fronts{i}) <= popSize
            % Update distances
            fronts{i} = crowdingDistanceAssignment(fronts{i}, objectives);
            parents = [parents, fronts{i}];
            
            i = i + 1;
        end
        
        % It should be crowd operator but the rank is the same in a front
        % and the crowd operator only concerns about rank and distance
        if length(parents) < popSize
            fronts{i} = crowdingDistanceAssignment(fronts{i}, objectives);
            fronts{i} = sortfun(@(indiv) indiv.distance, fronts{i}, 'descend');
            parents = [parents, fronts{i}(1:popSize-length(parents))];
        end
        
        children = makeNewPopulation(parents, config);
    end
end

function population = generatePopulation(config)
    popSize = config.popSize;
    population(popSize) = individual;
    
    for i=1:popSize
        population(i).variable = utils.randBetween( ...
            config.varMin, config.varMax);
    end
end

function population = evaluate(population, objectives)
    popSize = length(population);
    countObjectives = length(objectives);
    
    for i=1:popSize
        population(i).objectiveValues = inf(1, countObjectives);
        
        for j=1:countObjectives
            population(i).objectiveValues(j) = ...
                objectives{j}.get(population(i).variable);
        end
    end
end

function children = makeNewPopulation(parents, config)
    matingPoolSize = length(parents) * config.probCrossover;
    matingPool = selection(parents, matingPoolSize);
    children = crossover(matingPool);
    children = mutation(children, config);
end

% Binary tournament
function matingPool = selection(population, matingPoolSize)
    popSize = length(population);
    if mod(matingPoolSize, 2) == 1 % If impair, remove 1
        matingPoolSize = matingPoolSize - 1;
    end
    matingPool(matingPoolSize) = individual;

    permutations = zeros(2, matingPoolSize);
    for j=1:2
        permutations(j,:) = randperm(popSize, matingPoolSize);
    end
    
    for i=1:matingPoolSize
        pool = permutations(:,i);
        indiv1 = population(pool(1));
        indiv2 = population(pool(2));
        
        if dominates(indiv1, indiv2)
            matingPool(i) = indiv1;
        elseif dominates(indiv2, indiv1)
            matingPool(i) = indiv2;
        else
            a = randi(2); % Generate 1 or 2
            if a == 1
                matingPool(i) = indiv1;
            else % if a = 2
                matingPool(i) = indiv2;
            end
        end
    end
end

% Whole arithmetic
function children = crossover(matingPool)
    matingPoolSize = length(matingPool);
    children(matingPoolSize) = individual;
    
    for i=2:2:matingPoolSize        
        parent1Var = matingPool(i-1).variable;
        parent2Var = matingPool(i).variable;
        
        a = rand();
        b = 1 - a;
        child1Var = a*parent1Var + b*parent2Var;
        child2Var = b*parent1Var + a*parent2Var;
        
        children(i-1).variable = child1Var;
        children(i).variable = child2Var;
    end
end

function children = mutation(children, config)    
    % CONSTANTS
    n = 2; % Polynomial N Factor
    
    countChildren = length(children);
    countMutations = countChildren * config.probMutation;
    mutantChildrenIdx = randperm(countChildren, countMutations);
    
    for i=1:countMutations
        var = children(mutantChildrenIdx(i)).variable;
        
        u = rand();
        if u < 0.5
            xi = (2*u)^(1/(n+1))-1;
        else
            xi = 1-(2*(1-u))^(1/(n+1));
        end

        dmax = min(config.varMax - var, var - config.varMin);
        var = var + dmax * xi;
        
        children(mutantChildrenIdx(i)).variable = var;
    end
end