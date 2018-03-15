classdef gen < display.base
    properties
        curGen
    end
    
    methods
        function obj = gen()
            obj.curGen = 0;
        end
        
        % Executed after each iteration
        function print(obj, ~)
            obj.curGen = obj.curGen + 1;
            fprintf('%d ', obj.curGen);
        end
        
        % Executed after final iteration
        function finalPrint(~, ~)
        end
    end
end

