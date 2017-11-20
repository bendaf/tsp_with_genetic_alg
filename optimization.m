%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number of individuals
NIND = 75;

% Maximum no. of generations
MAXGEN = 300;

% percentage of the elite population
ELITIST = 0.103;

% probability of crossover
PR_CROSS = 1;

% probability of mutation
PR_MUT = 0.2897;

% default crossover operator
CROSSOVER = {'combin_edges', 'combin_cross_edges', 'xalt_edges'};

% default mutation operator
MUTATION = {'inversion'};

% The type of representation used in the ga. 
% 1 - Path, 2 - Adjacency, 3 - Ordinal
REPRESENTATION = 2; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ELITIST[0, 0.05, 0.1, 0.2]: 0.1, PR_CROSS[1, 0.95, 0.9, 0.8]: 0.8,
% PR_MUT[0, 0.05, 0.1, 0.2]: 0.1

% ELITIST[0.07, 0.09, 0.1, 0.125, 0.15]: 0.15, PR_CROSS[.8]: 0.8,
% PR_MUT[0.07, 0.09, 0.1, 0.125, 0.15]: 0.15

% ELITIST[0.125, 0.15, 0.175]: 0.175, PR_CROSS[.85 .8 .75 .65]: 0.65,
% PR_MUT[0.125, 0.15, 0.175]: 0.15

% PR_CROSS[.85, .75, .7, .65, .6, .5]: .75 CROSSOVER {'combin_edges',
% 'xalt_edges'}: combin_edges

% PR_MUT[0.14, 0.15, 0.16, 0.175, 0.19, 0.2]: 0.19
% MUTATION{'inversion', 'insertion'}: 'inversion'

% NIND = [25, 50, 75, 100, 200, 300, 500, 600]: 75 (TIME: 60)
% MAXGEN = [50, 100, 200, 300, 500, 600]: 500 (TIME: 60)
[ best, log] = find_best(NIND, MAXGEN, ELITIST, PR_CROSS, PR_MUT, CROSSOVER, MUTATION, REPRESENTATION, 60, 20);
plot_optimalization('Crossover local optimization', CROSSOVER, log, 'Crossover operator', 'Route len');
best
