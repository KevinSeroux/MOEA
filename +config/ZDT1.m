function [conf, debugParetoFront] = ZDT1(debugParetoFrontSize)
    objectives = { objective.ZDT1_1(1:30), objective.ZDT1_2(1:30) };
    
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