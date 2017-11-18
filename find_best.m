function best_vars = find_best(NIND, MAXGEN, ELITIST, ...
    PR_CROSS, PR_MUT, CROSSOVER, MUTATION, REPRESENTATION, TIME, REPETITION)

    % start with first dataset
    data = load('datasets/rondrit100.tsp');
    x = data(:,1)/max([data(:,1);data(:,2)]);
    y = data(:,2)/max([data(:,1);data(:,2)]);
    NVAR = size(data,1);
    
    minlen = intmax;
    for nind = NIND
        for maxgen = MAXGEN
            for elit = ELITIST
                for crossprob = PR_CROSS
                    for mutprob = PR_MUT
                        for cros_i = 1:size(CROSSOVER, 2)
                            for mut_i = 1:size(MUTATION, 2)
                                for repr = REPRESENTATION
                                    lens = zeros(REPETITION, 1);
                                    for i = 1:REPETITION
                                        lens(i) = run_ga(x,y,nind,maxgen,NVAR,elit, ...
                                            1, crossprob, mutprob, CROSSOVER{cros_i}, ...
                                            MUTATION{mut_i}, 1, repr, TIME);
                                    end
                                    len = mean(lens);
                                    if len < minlen
                                        minlen = len
                                        best_vars = {nind, maxgen, elit, ...
                                            crossprob, mutprob, CROSSOVER{cros_i}, ...
                                            MUTATION{mut_i}, repr};
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end 
end