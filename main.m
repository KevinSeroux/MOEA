population = geneticAlgorithm(FON());

function myconfig = SCH()
    myconfig = config();
    myconfig.variables = [ myconfig.variables ; {
        -1000 1000
    }];
    myconfig.objectives = { objective.SCH1(1), objective.SCH2(1) };
end

function myconfig = FON()
    myconfig = config();
    myconfig.variables = [ myconfig.variables ; {
        -4 4 ;
        -4 4 ;
        -4 4
    }];
    myconfig.objectives = { objective.FON1([1 2 3]), objective.FON2([1 2 3]) };
end