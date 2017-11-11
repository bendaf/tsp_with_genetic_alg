%
% path2ord(Path)
% function to convert between path and ordinal representation for TSP
% Path and Ord are row vectors
%

function Ord = path2ord(Path)

	Ord = zeros(size(Path));
    for j= 1:size(Path,1)
        
        L = 1:size(Path,2);
        for t = 1:size(Path,2)
            for i = 1:size(L,2)
                if Path(j, t) == L(i)
                    Ord(j, t) = i;
                    L(i) = [];
                    break;
                end
            end
        end
    end

% End of function

