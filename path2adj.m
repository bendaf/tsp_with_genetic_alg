%
% path2adj(Path)
% function to convert between path and adjacency representation for TSP
% Path and Adj are row vectors
%

function Adj = path2adj(Path)
    Adj=zeros(size(Path));
    for i = 1:size(Path,1)
        for t=1:size(Path,2)-1
            Adj(i, Path(i, t)) = Path(i, t+1);
        end
        Adj(i, Path(i, size(Path,2))) = Path(i, 1);
    end

% End of function

