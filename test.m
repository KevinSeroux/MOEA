debugParetoFrontSize = 500;
sample = 1;
tests = {
    @() config.SCH(debugParetoFrontSize), ...
    @() config.FON(debugParetoFrontSize), ...
    @() config.ZDT1(debugParetoFrontSize), ...
    @() config.ZDT2(debugParetoFrontSize), ...
    @() config.ZDT3(debugParetoFrontSize), ...
    @() config.ZDT4(debugParetoFrontSize), ...
    @() config.ZDT6(debugParetoFrontSize), ...
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