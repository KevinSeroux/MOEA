classdef config < handle  
    properties
        popSize
        probCrossover % Mating pool size = popSize * probCrossover
        probMutation % Mutants count = Mating pool size * probMutation
        display
        
        % Mandatory to be defined by user
        varMin
        varMax
        objectives
    end
    
    methods
        function obj = config()
            obj.popSize = 100;
            obj.probCrossover = 0.5;
            obj.probMutation = 0.2;
            obj.display = {display.graph(), display.text()};
        end
    end
end

