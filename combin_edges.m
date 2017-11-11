% edge recombination crossover for TSP
%
% KULeuven, november 2017
%
% Syntax:  NewChrom = combin_edges(OldChrom, XOVR, Repr)
%
% Input parameters:
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual
%                (in any form, not necessarily real values).
%    XOVR      - Probability of recombination occurring between pairs
%                of individuals.
%    Repr      - Representation of the population
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after mating, ready to be mutated and/or evaluated,
%                in the same format as OldChrom.
%

function NewChrom = combin_edges(OldChrom, XOVR, Repr)

    if nargin < 2, XOVR = NaN; end
    
    [rows, cols] = size(OldChrom);
    NewChrom = zeros(size(OldChrom));
    maxrows = rows;
    if rem(rows,2) ~= 0
        maxrows = maxrows-1;
    end   
    
    for row = 1:2:maxrows
	
        % crossover of the two chromosomes
        % results in 2 offsprings
        if rand < XOVR			% recombine with a given probability
            NewChrom(row,:) = edge_recombination( ...
                [OldChrom(row,:); OldChrom(row+1,:)], Repr);
            NewChrom(row+1,:) = edge_recombination( ...
                [OldChrom(row+1,:); OldChrom(row,:)], Repr);
        else
            NewChrom(row,:) = OldChrom(row,:);
            NewChrom(row+1,:) = OldChrom(row+1,:);
        end
    end

    if rem(rows,2) ~= 0
        NewChrom(rows,:) = OldChrom(rows,:);
    end
end
   

% End of function
