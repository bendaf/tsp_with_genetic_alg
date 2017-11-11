% low level function for TSP mutation
% insertion: insert one city before/after others
% Representation is an integer specifying which encoding is used
%   1 : adjacency representation
%   2 : path representation
%   3 : ordinal representation
%

function NewChrom = insertion(OldChrom, Repr)

    NewChrom = conv_repr(OldChrom, Repr, 1);

    % select two positions in the tour
    rndi = zeros(1,2);

    while abs(rndi(1)-rndi(2)) <= 1
        rndi = rand_int(1, 2, [1 size(NewChrom, 2)]);
    end

    if rndi(1) < rndi(2)
        buffer = NewChrom(rndi(1)+1:rndi(2)-1);
        NewChrom(rndi(1)+1) = NewChrom(rndi(2));
        NewChrom(rndi(1)+2:rndi(2)) = buffer;
    else
        buffer = NewChrom(rndi(2)+1:rndi(1)-1);
        NewChrom(rndi(1)-1) = NewChrom(rndi(2));
        NewChrom(rndi(2):rndi(1)-2) = buffer;
    end


    NewChrom = conv_repr(NewChrom, 1, Repr);

end
% End of function
