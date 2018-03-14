classdef text < display.base
    properties
        bestIndiv
    end
    
    methods        
        function print(~, ~)
        end
        
        function finalPrint(obj, pop)
            obj.printPop(pop)
        end
        
        function printPop(~, pop)
            for i=1:length(pop)
                fprintf(pop(i).toString());
            end
        end
    end
end

