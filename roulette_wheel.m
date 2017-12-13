% TOURNAMENT.M          (Stochastic Universal Sampling)
% based off of the implementation in the ga toolbox
% modified by Danica Reardon d.reardon@live.com
%
% This function performs selection with a binary tournament.
%
% Syntax:  NewChrIx = tournament(FitnV, Nsel)
%
% Input parameters:
%    FitnV     - Column vector containing the fitness values of the
%                individuals in the population.
%    Nsel      - number of individuals to be selected
%
% Output parameters:
%    NewChrIx  - column vector containing the indexes of the selected
%                individuals relative to the original population, shuffled.
%                The new population, ready for mating, can be obtained
%                by calculating OldChrom(NewChrIx,:).

function NewChrIx = roulette_wheel(FitnV, Nsel)

    FitnV = FitnV + 0.00001;
    FitnV = 1./FitnV;
    % Identify the population size (Nind)
    [Nind, ~] = size(FitnV);

    % Perform stochastic universal sampling
    cumfit = cumsum(FitnV);
    NewChrIx = zeros(Nsel,1);
    for i=1:Nsel
        sel = rand * cumfit(Nind);
        NewChrIx(i) = find(cumfit == min(cumfit(cumfit > sel)));
    end
    
    NewChrIx = NewChrIx(randperm(Nsel));
    
end
