function run_config(algorithm, problem, population_size, ...
    max_generation, mutation_probability, crossover_probability)

    if (strcmp(algorithm, 'SPEA2'))

    elseif (strcmp(algorithm, 'NSGA-II'))
        run_nsgaii(problem, population_size, max_generation, ...
            mutation_probability, crossover_probability);
    else
        assert(false, algorithm + ' is not a valid algorithm');
    end
end