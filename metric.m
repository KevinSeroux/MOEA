classdef metric
    properties
        paretoFront
    end
    
    methods
        function obj = metric(paretoFront)
            obj.paretoFront = paretoFront;
        end
        
        function convergence = computeConvergence(obj, pop)
            popSize = length(pop);
            convergence = 0;
            
            for i=1:popSize
                bestDist = inf;
                
                for j=1:length(obj.paretoFront)
                    curDist = utils.distance(pop(i), obj.paretoFront(j));
                    
                    if curDist < bestDist
                        bestDist = curDist;
                    end
                end
                
                convergence = convergence + bestDist;
            end
            
            convergence = convergence / popSize;
        end
        
        function diversity = computeDiversity(obj, pop)  
            % Sort to get the correct df and dl
            sortedParetoFront = obj.sortPopulation(obj.paretoFront);
            sortedPop = obj.sortPopulation(pop);
            
            df = utils.distance(sortedPop(1), sortedParetoFront(1));
            dl = utils.distance(sortedPop(end), sortedParetoFront(end));
            
            countDist = length(sortedPop) - 1;
            % Store all the distances
            d = nan(1, countDist);
            for i=1:countDist
                d(i) = utils.distance(sortedPop(i), sortedPop(i+1));
            end
            dmean = mean(d);
            
            diversity = (df + dl + sum(abs(d - dmean))) / ...
                (df + dl + countDist * dmean);
        end
        
        function [bestIndiv, nearestOptimalIndiv] = getBestIndiv(obj, pop)
            bestDist = inf;
            
            for i=1:length(pop)
                curIndiv = pop(i);
                    
                for j=1:length(obj.paretoFront)
                    curOptimalIndiv = obj.paretoFront(j);
                    
                    curDist = utils.distance(curIndiv, curOptimalIndiv);
                    if curDist < bestDist
                        bestDist = curDist;
                        bestIndiv = curIndiv;
                        nearestOptimalIndiv = curOptimalIndiv;
                    end
                end
            end
        end
    end
    
    methods(Access = private)
        function sortedPop = sortPopulation(~, pop)            
            % We can sort according to one objective value
            var1 = arrayfun(@(indiv) indiv.objectiveValues(1), pop);
            [~, idx] = sort(var1);
            
            sortedPop = pop(idx);
        end
    end
end

