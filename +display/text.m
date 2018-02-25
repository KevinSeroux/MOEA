classdef text < display.base
    properties
        bestIndiv
    end
    
    methods        
        function print(~, population)
            disp('====================');

            for i=1:length(population)
                indiv = population(i);
                objectiveValues = indiv.objectiveValues;

                sentance = strcat(num2str(indiv.variable), ' =>');
                for j=1:length(objectiveValues)
                    sentance = strcat([sentance, ' ', num2str(objectiveValues(j)), ',']);
                end

                disp(sentance);
            end
        end
    end
end

