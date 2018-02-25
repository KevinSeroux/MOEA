classdef text < display.base
    properties
        bestIndiv
    end
    
    methods        
        function print(~, population)
            disp('====================');

            for i=1:length(population)
                indiv = population(i);
                sentance = '';

                variables = indiv.variables;
                for j=1:length(variables)
                    sentance = strcat([sentance, ' ', num2str(variables(j)), ',']);
                end
                
                sentance = strcat(sentance, ' =>');
                
                objectiveValues = indiv.objectiveValues;
                for j=1:length(objectiveValues)
                    sentance = strcat([sentance, ' ', num2str(objectiveValues(j)), ',']);
                end

                disp(sentance);
            end
        end
    end
end

