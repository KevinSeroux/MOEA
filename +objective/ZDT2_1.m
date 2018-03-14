classdef ZDT2_1 < objective.base
    methods
        function obj = ZDT2_1(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)          
            value = x(1);
        end
    end
end

