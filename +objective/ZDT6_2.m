classdef ZDT6_2 < objective.base
    methods
        function obj = ZDT6_2(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(obj, x)
            f1x = obj.f1(x);
            gx = obj.g(x);
            
            value = gx * (1 - (f1x / gx)^2);
        end
        
        function value = f1(~, x)
            x1 = x(1);
            
            value = 1 - exp(-4*x1)*sin(6*pi*x1)^6;
        end
        
        function value = g(~, x)
            n = length(x);
            
            value = 1 + 9*(sum(x(2:n)) / (n-1))^0.25;
        end
    end
end

