
% This function is for selecting the city with the less connection in 
% edgeList from cities. If it is equal it returns with a random city.

function city = select_city(edgeList, cities)
    if nargin > 5
        error('requires at most 2 inputs');
    end
    
    switch nargin
        case 1
            cities = 1:size(edgeList, 1);
    end
    cities(cities == 0) = [];
    
    bestCities = [];
    smallestConn = 4;
    for i = 1:size(cities, 2)
        conn = size(unique(edgeList(cities(i),:)), 2);
        if size(find(edgeList(cities(i),:) == 0),2) > 0
            conn = conn - 1;
        end
        
        if smallestConn > conn && conn > 0
            bestCities = cities(i);
            smallestConn = conn;
        elseif smallestConn == conn
            bestCities = [bestCities, cities(i)];
        end
    end
    if size(bestCities, 2) == 0
        bestCities = unique(edgeList);
        bestCities(bestCities == 0) = [];
    end
    city = datasample(bestCities,1);
end