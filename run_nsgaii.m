function run_nsgaii(pb, popSize, maxGen, pm, pc)
    debugParetoFrontSize = 500;
    
    switch pb
        case 'SCH'
            [conf, paretoFront] = config.SCH(debugParetoFrontSize);
        case 'FON'
            [conf, paretoFront] = config.FON(debugParetoFrontSize);
        case 'ZDT1'
            [conf, paretoFront] = config.ZDT1(debugParetoFrontSize);
        case 'ZDT2'
            [conf, paretoFront] = config.ZDT2(debugParetoFrontSize);
        case 'ZDT3'
            [conf, paretoFront] = config.ZDT3(debugParetoFrontSize);
        case 'ZDT4'
            [conf, paretoFront] = config.ZDT4(debugParetoFrontSize);
        case 'ZDT6'
            [conf, paretoFront] = config.ZDT6(debugParetoFrontSize);
    end

    conf.maxGen = maxGen;
    conf.popSize = popSize;
    conf.probCrossover = pc;
    conf.probMutation = pm;
    
    stat = metric(paretoFront);
    pop = geneticAlgorithm(conf);

    convergence = stat.computeConvergence(pop);
    diversity = stat.computeDiversity(pop);
        [bestIndiv, nearestOptimalIndiv] = stat.getBestIndiv(pop);
        
    fprintf('Best indiv: %s\n', bestIndiv.toString());
    fprintf('Nearest optimal: %s\n', nearestOptimalIndiv.toString());
    fprintf('Conv: %f, Div: %f\n', convergence, diversity);
end