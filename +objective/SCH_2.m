classdef SCH_2 < objective.base    
    methods
        function obj = SCH_2(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)            
            value = (x-2)^2;
        end
    end
end

