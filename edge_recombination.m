% Edge recombination crossover for TSP
% low level function for calculating an offspring
% given 2 parent in the Parents - agrument
% Parents is a matrix with 2 rows, each row
% represent the genocode of the parent
%
% This function assumes that the ordinal representation is used.


function Offspring = edge_recombination(Parents, Repr)
    
    edgeList = zeros(size(Parents, 2), 4);
    if Repr == 1
        edgeList(:,1:2) = create_edgeList_path(Parents(1,:));
        edgeList(:,3:4) = create_edgeList_path(Parents(2,:));
        Offspring = create_child_path(edgeList);
    elseif Repr == 2
        edgeList(:,1:2) = create_edgeList_adj(Parents(1,:));
        edgeList(:,3:4) = create_edgeList_adj(Parents(2,:));
        Offspring = create_child_adj(edgeList);
    elseif Repr == 3
        edgeList(:,1:2) = create_edgeList_ordinal(Parents(1,:));
        edgeList(:,3:4) = create_edgeList_ordinal(Parents(2,:));
        Offspring = create_child_ordinal(edgeList);
    end
    
end
% End of function

function edgeList = create_edgeList_ordinal(parent)
    gens = size(parent, 2); 
    L = 1:gens;
    edgeList = zeros(gens, 2);
	firstCity = L(parent(1));
    previousCity = L(parent(1));
    L(parent(1)) = [];
    for t = 2:gens
		edgeList(L(parent(t)), 1) = previousCity;
        edgeList(previousCity, 2)  = L(parent(t));
        previousCity = L(parent(t));
		L(parent(t)) = [];
        if size(L, 2) == 0
            edgeList(firstCity, 1) = previousCity;
            edgeList(previousCity, 2) = firstCity;
        end
    end
end

function Offspring = create_child_ordinal(edgeList)
    gens = size(edgeList, 1);
	Offspring = zeros(1, gens);
    
    %select starting city
    currentCity = select_city(edgeList);
    L = 1:gens;
    
    for i = 1:gens-1
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
    Offspring(gens) = 1;
end

function edgeList = create_edgeList_adj(parent)
    gens = size(parent, 2); 
    edgeList = zeros(gens, 2);
	edgeList(:,2) = parent';
    for i = 1:gens
        edgeList(parent(i),1) = i;
    end
end

function Offspring = create_child_adj(edgeList)
    gens = size(edgeList, 1);
	Offspring = zeros(1, gens);
    
    firstCity = select_city(edgeList);
    prevCity = firstCity;
    edgeList(edgeList == prevCity) = 0;
    for i = 1:gens-1
        currentCity = select_city(edgeList, edgeList(prevCity, :));
        edgeList(edgeList == currentCity) = 0;
        Offspring(prevCity) = currentCity;
        prevCity = currentCity;
    end
    Offspring(currentCity) = firstCity;
end

function edgeList = create_edgeList_path(parent)
    gens = size(parent, 2); 
    edgeList = zeros(gens, 2);
    edgeList(1,1) = parent(gens);
    edgeList(gens,2) = parent(1);
    for i = 2:gens
        edgeList(parent(i),1) = parent(i-1);
        edgeList(parent(i-1),2) = parent(i);
    end
end

function Offspring = create_child_path(edgeList)
    gens = size(edgeList, 1);
	Offspring = zeros(1, gens);
    
    %select starting city
    currentCity = select_city(edgeList);
    for i = 1:gens-1
        edgeList(edgeList == currentCity) = 0;
        Offspring(i) = currentCity;
        currentCity = select_city(edgeList, edgeList(currentCity, :));
    end
    Offspring(gens) = currentCity;
end
