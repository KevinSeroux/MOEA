classdef FON_2 < objective.base
    methods
        function obj = FON_2(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)
            assert(length(x) == 3)
            
            value = 1 - exp(-sum((x+(1/sqrt(3))).^2));
        end
    end
end

