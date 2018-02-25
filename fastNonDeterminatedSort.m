function fronts = fastNonDeterminatedSort(population)
    popSize = length(population);
    dominatedSolutions = cell(1, popSize);
    countDominantSolutions = zeros(1, popSize);
    fronts = {[]}; % Initialize first front
    
    % i and j are indices of individuals
    for indiv1Idx=1:popSize
        for indiv2Idx=1:popSize
            indiv1 = population(indiv1Idx);
            indiv2 = population(indiv2Idx);
            
            % If indiv1 dominates (pareto) indiv2
            if dominates(indiv1, indiv2)
                dominatedSolutions{indiv1Idx} = [dominatedSolutions{indiv1Idx}, indiv2Idx];
            elseif dominates(indiv2, indiv1)
                countDominantSolutions(indiv1Idx) = countDominantSolutions(indiv1Idx) + 1;
            % We don't care if neither indiv1 or indiv2 dominates the other
            end
        end
        
        % Fill first front
        if countDominantSolutions(indiv1Idx) == 0
            population(indiv1Idx).rank = 1;
            fronts{1} = [fronts{1}, indiv1Idx]; % TODO: Not sure
        end
    end
        
    frontIdx = 1;
    currentFront = fronts{frontIdx};
    while ~isempty(currentFront) % While there is non-empty fronts
        nextFront = [];

        % For each individual in the current front
        for i=1:length(currentFront)
            indivIdx = currentFront(i);
            indivDominations = dominatedSolutions{indivIdx};
            
            % For each dominated individual
            for j=1:length(indivDominations)
                dominatedIndivIdx = indivDominations(j);
                
                countDominantSolutions(dominatedIndivIdx) = ...
                    countDominantSolutions(dominatedIndivIdx) - 1;
                
                if countDominantSolutions(dominatedIndivIdx) == 0
                    population(dominatedIndivIdx).rank = frontIdx + 1;
                    nextFront = [nextFront, dominatedIndivIdx];
                end
            end
        end

        % Indices to individuals
        fronts{frontIdx} = population(fronts{frontIdx});
        
        % Next front
        frontIdx = frontIdx + 1;
        fronts{frontIdx} = nextFront;
        currentFront = nextFront;
    end
end

