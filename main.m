myconfig = config();

myconfig.varMin = -1000;
myconfig.varMax = 1000;
myconfig.objectives = { objective.SCH1(), objective.SCH2() };
population = geneticAlgorithm(myconfig);