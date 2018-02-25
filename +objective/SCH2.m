classdef SCH2 < objective.base    
    methods (Access = protected)
        function value = compute(~, x)            
            value = (x-2)^2;
        end
    end
end

