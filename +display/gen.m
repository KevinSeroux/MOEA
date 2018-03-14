classdef gen < display.base
    properties
        curGen
    end
    
    methods
        function obj = gen()
            obj.curGen = 0;
        end
        
        function print(obj, ~)
            obj.curGen = obj.curGen + 1;
            fprintf('%d ', obj.curGen);
        end
        
        function finalPrint(~, ~)
        end
    end
end

