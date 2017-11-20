function min_len = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, ...
    PR_CROSS, PR_MUT, CROSSOVER, MUTATION, LOCALLOOP, REPRESENTATION, TIME, ...
    ah1, ah2, ah3 )
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, MUTATION, REPRESENTATION,
%               TIME, ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% MUTATION: the mutation operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
% REPRESENTATION: Representation of the path.
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER ...
    MUTATION LOCALLOOP REPRESENTATION};

        if nargin < 17
            useVisualisation = 0;
            if nargin < 14
                TIME = 60;
            end
        else
            useVisualisation = 1;
        end
        tic
        GGAP = 1 - ELITIST;
        mean_fits = zeros(1,MAXGEN+1);
        worst = zeros(1,MAXGEN+1);
        Dist = zeros(NVAR,NVAR);
        for i = 1:size(x,1)
            for j = 1:size(y,1)
                Dist(i,j) = sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        % initialize population
        Chrom = zeros(NIND,NVAR);
        for row = 1:NIND
            Chrom(row,:) = conv_repr(randperm(NVAR), 1, REPRESENTATION);
        end
        gen = 0;
        % number of individuals of equal fitness needed to stop
        stopN = ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        ObjV = tspfun(Chrom, Dist, REPRESENTATION);
        best = zeros(1, MAXGEN);
        min_len = min(ObjV);
        % generational loop
        while gen < MAXGEN
            sObjV = sort(ObjV);
          	[best(gen+1), t] = min(ObjV);
            min_len = min(best(gen+1), min_len);
            mean_fits(gen+1) = mean(ObjV);
            worst(gen+1) = max(ObjV);
            
            if useVisualisation
                visualizeTSP(x, y, conv_repr(Chrom(t, :), REPRESENTATION, 1), ...
                    best(gen+1), ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
            end
            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
        	%assign fitness values to entire population
        	FitnV = ranking(ObjV);
        	%select individuals for breeding
        	SelCh = select('sus', Chrom, FitnV, GGAP);
        	%recombine individuals (crossover)
            SelCh = feval(CROSSOVER, SelCh, PR_CROSS, REPRESENTATION);
            SelCh = mutateTSP(MUTATION, SelCh, PR_MUT, REPRESENTATION);
            %evaluate offspring, call objective function
        	ObjVSel = tspfun(SelCh, Dist, REPRESENTATION);
            %reinsert offspring into population
        	[Chrom ObjV] = reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);
            
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom, LOCALLOOP, ...
                Dist, REPRESENTATION);
        	%increment generation counter
        	gen = gen+1;
            if toc > TIME
                break;
            end
        end
end
