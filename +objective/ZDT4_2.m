classdef ZDT4_2 < objective.base
    methods
        function obj = ZDT4_2(args)
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
            
            value = 1 + 10*(n - 1) + sum(x(2:n).^2 - 10*cos(4*pi*x(2:n)));
        end
    end
end

