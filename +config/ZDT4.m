function [conf, debugParetoFront] = ZDT4(debugParetoFrontSize)
    objectives = { objective.ZDT4_1(1:10), objective.ZDT4_2(1:10) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 10);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config.config();
    conf.variables = [ conf.variables ;
        {0 1} ;
        num2cell(repmat([-5 5], 9, 1))
    ];
    conf.objectives = objectives;
end