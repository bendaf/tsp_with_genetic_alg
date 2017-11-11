%
% ord2path(ord)
% function to convert between ordinal and path representation for TSP
% ord, Path are row vectosr
%

function Path = ord2path(Ord)
    Path = zeros(size(Ord));
    for i = 1:size(Ord,1)
        L = 1:size(Ord,2);
        for t = 1:size(Ord, 2)
            Path(i, t) = L(Ord(i, t));
            L(Ord(i, t)) = [];
        end
    end

% End of function

