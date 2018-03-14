classdef KUR_1 < objective.base
    methods
        function obj = KUR_1(args)
            % Invoke superclass constructor
            obj = obj@objective.base(args);
        end
    end
    
    methods (Access = protected)
        function value = compute(~, x)
            assert(length(x) == 3);
            
            neighborSum = x(1:end-1) + x(2:end);
            
            value = sum(-10*exp(-0.2*sqrt(neighborSum)));
        end
    end
end

