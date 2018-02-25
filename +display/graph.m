classdef graph < display.base
    properties
        countObjectives
        means % Each row = different objective function
    end
    
    methods
        function obj = graph()
            obj.countObjectives = nan;
        end
        
        function print(obj, population)
            if isnan(obj.countObjectives)
                obj.countObjectives = length(population(1).objectiveValues);
                obj.means = nan(obj.countObjectives, 0);
                figure
            end
            
            curMeans = nan(obj.countObjectives, 1);
            for i=1:obj.countObjectives
                curMeans(i) = mean( ...
                    arrayfun(@(indiv) indiv.objectiveValues(i), population) ...
                );
            end
            obj.means = [obj.means, curMeans];
            
            obj.draw();
        end
        
        function draw(obj)            
            title('Measurements')
            xlabel('Generation')

            for i=1:obj.countObjectives
                semilogy(obj.means(i,:));
                hold on
            end
            hold off
            ylabel('Objective Values')
            
            drawnow
        end
    end
end

