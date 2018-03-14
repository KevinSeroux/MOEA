function firstFront = geneticAlgorithm(config)
    display = config.display;
    objectives = config.objectives;
    popSize = config.popSize;
    
    parents = [];
    children = generatePopulation(config); % First generation
    
    for gen=1:config.maxGen
        children = evaluate(children, objectives);
        population = [parents, children];
        fronts = fastNonDeterminatedSort(population);
        firstFront = fronts{1};
        
        % User feedback
        for i=1:length(display); display{i}.print(firstFront); end
        
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
            fronts{i} = utils.sortfun(@(indiv) indiv.distance, fronts{i}, 'descend');
            parents = [parents, fronts{i}(1:popSize-length(parents))];
        end
        
        children = makeNewPopulation(parents, config);
    end
    
    % User feedback
    for i=1:length(display); display{i}.finalPrint(firstFront); end
end

function population = generatePopulation(config)
    popSize = config.popSize;
    variables = config.variables;
    countVariables = height(variables);
    population(popSize) = individual;
    
    for i=1:popSize
        population(i).variables = nan(1, countVariables);
        
        for j=1:countVariables
            population(i).variables(j) = utils.randBetween( ...
                variables{j, 'min'}, variables{j, 'max'});
        end
    end
end

function children = makeNewPopulation(parents, config)
    matingPoolSize = length(parents) * config.probCrossover;
    matingPool = selection(parents, matingPoolSize);
    children = crossover(matingPool, config);
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
function children = crossover(matingPool, config)
    matingPoolSize = length(matingPool);
    countVariables = height(config.variables);
    children(matingPoolSize) = individual;
    
    for i=2:2:matingPoolSize
        children(i).variables = nan(1, countVariables);
        
        a = rand();
        b = 1 - a;
        
        for j=1:countVariables
            parent1Var = matingPool(i-1).variables(j);
            parent2Var = matingPool(i).variables(j);

            child1Var = a*parent1Var + b*parent2Var;
            child2Var = b*parent1Var + a*parent2Var;

            children(i-1).variables(j) = child1Var;
            children(i).variables(j) = child2Var;
        end
    end
end

function children = mutation(children, config)    
    % CONSTANTS
    n = 2; % Polynomial N Factor
    
    variables = config.variables;
    countVariables = height(variables);
    countChildren = length(children);
    countMutations = round(countChildren * config.probMutation);
    mutantChildrenIdx = randperm(countChildren, countMutations);
    
    for i=1:countMutations        
        for j=1:countVariables
            var = children(mutantChildrenIdx(i)).variables(j);
        
            u = rand();
            if u < 0.5
                xi = (2*u)^(1/(n+1))-1;
            else
                xi = 1-(2*(1-u))^(1/(n+1));
            end

            dmax = min(variables{j, 'max'} - var, var - variables{j, 'min'});
            var = var + dmax * xi;

            children(mutantChildrenIdx(i)).variables(j) = var;
        end
    end
end