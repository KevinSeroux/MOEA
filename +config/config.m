classdef config < handle  
    properties
        % Optional
        maxGen
        popSize
        probCrossover % Mating pool size = popSize * probCrossover
        probMutation % Mutants count = Mating pool size * probMutation
        display
        
        % Mandatory to be filled by user
        variables
        objectives
    end
    
    methods
        function obj = config()
            obj.maxGen = 1;
            obj.popSize = 250;
            obj.probCrossover = 0.9;
            obj.probMutation = 0.1;
            obj.display = {display.gen()};
            obj.variables = table([], [], 'VariableNames', {'min' 'max'});
        end
    end
end

