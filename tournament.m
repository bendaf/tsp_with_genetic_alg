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

function NewChrIx = tournament(FitnV,Nsel)

tournSize = 5;
N_ind=size(FitnV,1);
ave=sum(1:N_ind)/N_ind;

for k = 1:Nsel
    Random_selection=min(N_ind,ave+(N_ind-ave)*randn(1,tournSize));
    selc = Random_selection(1);
    for kk = 2:tournSize
        if FitnV(Rsel(kk)) <= FitnV(selc)
            selc = Random_selection(kk);
        end
    end
    NewChrIx(k) = selc;
end