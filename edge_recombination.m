% Edge recombination crossover for TSP
% low level function for calculating an offspring
% given 2 parent in the Parents - agrument
% Parents is a matrix with 2 rows, each row
% represent the genocode of the parent
%
% This function assumes that the ordinal representation is used.


function Offspring = edge_recombination(Parents, Repr)
    cols = size(Parents, 2);
	Offspring = zeros(1, cols);
    
    Parents = conv_repr(Parents, Repr, 3);
    edgeList = zeros(cols, 4);
    
    %first parent
    L = 1:cols;
	firstCity = L(Parents(1, 1));
    previousCity = L(Parents(1, 1));
    L(Parents(1, 1)) = [];
	for t = 2:size(Parents,2)
		edgeList(L(Parents(1,t)), 1) = previousCity;
        edgeList(previousCity, 2)  = L(Parents(1,t));
        previousCity = L(Parents(1,t));
		L(Parents(1,t)) = [];
        if size(L,2) == 0
            edgeList(firstCity, 1) = previousCity;
            edgeList(previousCity, 2) = firstCity;
        end
    end
    
    %second parent
    L = 1:cols;
	firstCity = L(Parents(2,1));
    previousCity = L(Parents(2,1));
    L(Parents(2,1)) = [];
    for t = 2:size(Parents, 2)
		edgeList(L(Parents(2,t)), 3) = previousCity;
        edgeList(previousCity, 4)  = L(Parents(2, t));
        previousCity = L(Parents(2,t));
		L(Parents(2,t)) = [];
        if size(L,2) == 0
            edgeList(firstCity, 3) = previousCity;
            edgeList(previousCity, 4) = firstCity;
        end
    end
    
    %select starting city
    currentCity = select_city(edgeList);
    L = 1:cols;
    
    for i = 1:cols-1
        for j = 1:size(L,2)
            if currentCity == L(j)
                Offspring(i) = j;
                L(j) = [];
                break;
            end
        end
        edgeList(edgeList == currentCity) = 0;
        currentCity = select_city(edgeList, edgeList(currentCity, :));
        
        
    end
    Offspring(cols) = 1;
    Offspring = conv_repr(Offspring, 3, Repr);
end
% End of function
