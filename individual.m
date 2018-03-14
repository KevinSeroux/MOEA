classdef individual  
    properties
        variables
        objectiveValues
        
        rank
        distance
    end
    
    methods
        function sentance = toString(obj)
            sentance = '';

            for j=1:length(obj.variables)
                sentance = strcat([sentance, ' ', num2str(obj.variables(j)), ',']);
            end

            sentance = strcat(sentance, ' =>');

            for j=1:length(obj.objectiveValues)
                sentance = strcat([sentance, ' ', num2str(obj.objectiveValues(j)), ',']);
            end
        end
    end
end

