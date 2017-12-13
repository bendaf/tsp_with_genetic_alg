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

function NewChrIx = tournament(FitnV,Nsel);

tournSize = 10;
[Nind,~] = size(FitnV);
NewChrIx = zeros(Nsel,1);

for i = 1:Nsel
    Rsel = randperm(Nind, tournSize);
    best = Rsel(1);
    for j = 2:tournSize
        if FitnV(Rsel(j)) <= FitnV(best)
            best = Rsel(j);
        end
    end
    NewChrIx(i) = best;
end
        
%[~, shuf] = sort(rand(Nsel, 1));
NewChrIx = NewChrIx(randperm(Nsel));
%NewChrIx = NewChrIx(shuf);
