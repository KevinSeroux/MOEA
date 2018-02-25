classdef (Abstract) base < handle    
    properties        
        valMin % Minimum possible value for objective function
        valMax % Maximum possible value for objective function
        % Indices of variables in parameter to use in function get()
        idxVarsOfInterest
    end
    
    methods
        function obj = base(idxVarsOfInterest)
            obj.idxVarsOfInterest = idxVarsOfInterest;
            obj.valMin = inf;
            obj.valMax = -inf;
        end
        
        function value = get(obj, variables)
            value = obj.compute(variables(obj.idxVarsOfInterest));
            obj.updateMinMax(value);
        end
    end
    
    methods (Abstract, Access = protected)
        % The lower, the better
        value = compute(variable)
    end
    
    methods (Access = private)        
        function updateMinMax(obj, value)
            % The two conditions are separated to change both min and max
            % in the first call
            
            if value > obj.valMax
                obj.valMax = value;
            end
            
            if value < obj.valMin
                obj.valMin = value;
            end
        end
    end
end

