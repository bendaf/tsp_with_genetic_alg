function [best_vars, log] = find_best(NIND, MAXGEN, ELITIST, ...
    PR_CROSS, PR_MUT, CROSSOVER, MUTATION, REPRESENTATION, TIME, REPETITION)

    % start with first dataset
    data = load('datasets/rondrit050.tsp');
    x = data(:,1)/max([data(:,1);data(:,2)]);
    y = data(:,2)/max([data(:,1);data(:,2)]);
    NVAR = size(data,1);
    
    log = zeros(1,size(CROSSOVER,2));
    minlen = intmax;
    for nind = NIND
        for maxgen = MAXGEN
            for elit = 1:size(ELITIST,2)
                for crossprob = 1:size(PR_CROSS,2)
                    for mutprob = 1:size(PR_MUT,2)
                        for cros_i = 1:size(CROSSOVER, 2)
                            for mut_i = 1:size(MUTATION, 2)
                                for repr = REPRESENTATION
                                    lens = zeros(REPETITION, 1);
                                    for i = 1:REPETITION
                                        lens(i) = run_ga(x,y,nind,maxgen,NVAR,ELITIST(elit), ...
                                            1, PR_CROSS(crossprob), PR_MUT(mutprob), CROSSOVER{cros_i}, ...
                                            MUTATION{mut_i}, 1, repr, TIME);
                                    end
                                    len = mean(lens);
                                    log(cros_i) = mean(lens);
                                    [size(log,2), nnz(log)]
                                    if len < minlen
                                        minlen = len;
                                        best_vars = {nind, maxgen, ELITIST(elit), ...
                                            PR_CROSS(crossprob), PR_MUT(mutprob), ...
                                            CROSSOVER{cros_i}, MUTATION{mut_i}, repr};
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
