debugParetoFrontSize = 500;
sample = 1;
tests = {
    %@() SCH(debugParetoFrontSize), ...
    %@() FON(debugParetoFrontSize), ...
    %@() ZDT1(debugParetoFrontSize), ...
    %@() ZDT2(debugParetoFrontSize), ...
    %@() ZDT3(debugParetoFrontSize), ...
    @() ZDT4(debugParetoFrontSize), ...
    %@() ZDT6(debugParetoFrontSize), ...
};

for i=1:length(tests)
    funConf = tests{i};
    fprintf('%s: ', func2str(funConf));
    
    convergences = nan(1, sample);
    diversities = nan(1, sample);
    
    for j=1:sample
        [conf, paretoFront] = funConf();
        stat = metric(paretoFront);
        
        pop = geneticAlgorithm(conf);
        
        convergences(j) = stat.computeConvergence(pop);
        diversities(j) = stat.computeDiversity(pop);
        
        % Test
        [bestIndiv, nearestOptimalIndiv] = stat.getBestIndiv(pop);
        fprintf('\n   Best indiv: %s\n', bestIndiv.toString());
        fprintf('   Nearest optimal: %s\n', nearestOptimalIndiv.toString());
    end
    
    fprintf('   Conv: %f, Div: %f\n', mean(convergences), mean(diversities));
end

function [conf, debugParetoFront] = SCH(debugParetoFrontSize)
    objectives = { objective.SCH_1(1), objective.SCH_2(1) };
    
    debugParetoFrontVariables = transpose(linspace(0, 2, debugParetoFrontSize));
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );
    
    conf = config();
    conf.variables = [ conf.variables ; {
        -1000 1000
    }];
    conf.objectives = objectives;
end

function [conf, debugParetoFront] = FON(debugParetoFrontSize)
    objectives = { objective.FON_1(1:3), objective.FON_2(1:3) };
    
    debugParetoFrontVariables = repmat( ...
        transpose(linspace(-1/sqrt(3), 1/sqrt(3), debugParetoFrontSize)), ...
        1, 3 ...
    );
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config();
    conf.variables = [ conf.variables ; 
        num2cell(repmat([-4 4], 3, 1))
    ];
    conf.objectives = objectives;
end

function [conf, debugParetoFront] = ZDT1(debugParetoFrontSize)
    objectives = { objective.ZDT1_1(1:30), objective.ZDT1_2(1:30) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 30);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config();
    conf.variables = [ conf.variables ;
        num2cell(repmat([0 1], 30, 1))
    ];
    conf.objectives = objectives;
end

function [conf, debugParetoFront] = ZDT2(debugParetoFrontSize)
    objectives = { objective.ZDT2_1(1:30), objective.ZDT2_2(1:30) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 30);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config();
    conf.variables = [ conf.variables ;
        num2cell(repmat([0 1], 30, 1))
    ];
    conf.objectives = objectives;
end

function [conf, debugParetoFront] = ZDT3(debugParetoFrontSize)
    objectives = { objective.ZDT3_1(1:30), objective.ZDT3_2(1:30) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 30);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config();
    conf.variables = [ conf.variables ;
        num2cell(repmat([0 1], 30, 1))
    ];
    conf.objectives = objectives;
end

function [conf, debugParetoFront] = ZDT4(debugParetoFrontSize)
    objectives = { objective.ZDT4_1(1:10), objective.ZDT4_2(1:10) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 10);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config();
    conf.variables = [ conf.variables ;
        {0 1} ;
        num2cell(repmat([-5 5], 9, 1))
    ];
    conf.objectives = objectives;
end

function [conf, debugParetoFront] = ZDT6(debugParetoFrontSize)
    objectives = { objective.ZDT6_1(1:10), objective.ZDT6_2(1:10) };
    
    debugParetoFrontVariables = zeros(debugParetoFrontSize, 10);
    debugParetoFrontVariables(:,1) = linspace(0, 1, debugParetoFrontSize);
    debugParetoFront = generateEvaluatedParetoFront( ...
        debugParetoFrontVariables, ...
        objectives ...
    );

    conf = config();
    conf.variables = [ conf.variables ;
        num2cell(repmat([0 1], 10, 1))
    ];
    conf.objectives = objectives;
end