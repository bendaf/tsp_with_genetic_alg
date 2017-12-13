function NewChrom = combin_cross_edges(OldChrom, XOVR, Repr)

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
            NewChrom(row+1,:) = cross_alternate_edges( ...
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
