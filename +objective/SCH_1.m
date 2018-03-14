classdef SCH_1 < objective.base
    methods
        function obj = SCH_1(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)            
            value = x^2;
        end
    end
end

