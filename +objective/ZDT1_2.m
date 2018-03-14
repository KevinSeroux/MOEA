classdef ZDT1_2 < objective.base
    methods
        function obj = ZDT1_2(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(obj, x)
            x1 = x(1);
            gx = obj.g(x);
            
            value = gx * (1 - sqrt(x1 / gx));
        end
        
        function value = g(~, x)
            n = length(x);
            
            value = 1 + 9 * sum(x(2:n)) / (n-1);
        end
    end
end

