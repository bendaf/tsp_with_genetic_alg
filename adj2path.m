%
% adj2path(Adj)
% function to convert between adjacency and path representation for TSP
% Adj, Path are row vectosr
%

function Path = adj2path(Adj)

	Path=zeros(size(Adj));
    for i = 1:size(Adj,1)
        walking_index=1;
        Path(i, 1)=1;
        for t=2:size(Adj,2)
            Path(i, t)=Adj(i, walking_index);
            walking_index=Path(i, t);
        end
    end

% End of function

