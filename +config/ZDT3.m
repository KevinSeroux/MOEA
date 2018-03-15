function [conf, debugParetoFront] = ZDT3(debugParetoFrontSize)
    objectives = { objective.ZDT3_1(1:30), objective.ZDT3_2(1:30) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 30);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config.config();
    conf.variables = [ conf.variables ;
        num2cell(repmat([0 1], 30, 1))
    ];
    conf.objectives = objectives;
end