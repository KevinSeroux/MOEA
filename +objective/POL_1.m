classdef POL_1 < objective.base
    methods
        function obj = POL_1(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)
            assert(length(x) == 2);
            
            x1 = x(1);
            x2 = x(2);
            
            a1 = 0.5*sin(1)  - 2*cos(1)  + sin(2)    - 1.5*cos(2);
            a2 = 1.5*sin(1)  - cos(1)    + 2*sin(2)  - 0.5*cos(2);
            b1 = 0.5*sin(x1) - 2*cos(x1) + sin(x2)   - 1.5*cos(x2);
            b2 = 1.5*sin(x1) - cos(x1)   + 2*sin(x2) - 0.5*cos(x2);
            
            value = 1 + (a1 - b1)^2 + (a2 - b2)^2;
        end
    end
end

