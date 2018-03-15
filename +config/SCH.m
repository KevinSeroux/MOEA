function [conf, debugParetoFront] = SCH(debugParetoFrontSize)
    objectives = { objective.SCH_1(1), objective.SCH_2(1) };
    
    debugParetoFrontVariables = transpose(linspace(0, 2, debugParetoFrontSize));
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );
    
    conf = config.config();
    conf.variables = [ conf.variables ; {
        -1000 1000
    }];
    conf.objectives = objectives;
end