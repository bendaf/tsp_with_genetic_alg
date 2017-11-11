% tsp_ImprovePopulation.m
% Author: Mike Matton
% 
% This function improves a tsp population by removing local loops from
% each individual.
%
% Syntax: improvedPopulation = tsp_ImprovePopulation(popsize, ncities, pop, improve, dists)
%
% Input parameters:
%   popsize           - The population size
%   ncities           - the number of cities
%   pop               - the current population (adjacency representation)
%   improve           - Improve the population (0 = no improvement, <>0 = improvement)
%   dists             - distance matrix with distances between the cities
%   repr              - representation of the population
%
% Output parameter:
%   improvedPopulation  - the new population after loop removal (if improve
%                          <> 0, else the unchanged population).

function newpop = tsp_ImprovePopulation(popsize, ncities, pop, improve, dists, repr)

if (improve)
   for i = 1:popsize
     
     result = improve_path(ncities, conv_repr(pop(i, :), repr, 1), dists);
  
     pop(i, :) = conv_repr(result, 1, repr);

   end
end

newpop = pop;