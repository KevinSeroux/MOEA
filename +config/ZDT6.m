function [conf, debugParetoFront] = ZDT6(debugParetoFrontSize)
    objectives = { objective.ZDT6_1(1:10), objective.ZDT6_2(1:10) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 10);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config.config();
    conf.variables = [ conf.variables ;
        num2cell(repmat([0 1], 10, 1))
    ];
    conf.objectives = objectives;
end