classdef config < handle  
    properties
        popSize
        probCrossover % Mating pool size = popSize * probCrossover
        probMutation % Mutants count = Mating pool size * probMutation
        display
        
        % Mandatory to be filled by user
        variables
        
        % Mandatory to be defined by user
        objectives
    end
    
    methods
        function obj = config()
            obj.popSize = 100;
            obj.probCrossover = 0.5;
            obj.probMutation = 0.2;
            obj.display = {display.graph(), display.text()};
            obj.variables = table([], [], 'VariableNames',{'min' 'max'});
        end
    end
end

