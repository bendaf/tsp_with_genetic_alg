% REINS.M        (RE-INSertion of offspring in population replacing parents)
%
% This function reinserts offspring in the population.
%
% Syntax: [Chrom, ObjVCh] = reins(Chrom, SelCh, SUBPOP, InsOpt, ObjVCh, ObjVSel)
%
% Input parameters:
%    Chrom     - Matrix containing the individuals (parents) of the current
%                population. Each row corresponds to one individual.
%    SelCh     - Matrix containing the offspring of the current
%                population. Each row corresponds to one individual.
%    SUBPOP    - (optional) Number of subpopulations
%                if omitted or NaN, 1 subpopulation is assumed
%    InsOpt    - (optional) Vector containing the insertion method parameters
%                ExOpt(1): Select - number indicating kind of insertion
%                          0 - uniform insertion
%                          1 - fitness-based insertion
%                          if omitted or NaN, 0 is assumed
%                ExOpt(2): INSR - Rate of offspring to be inserted per
%                          subpopulation (% of subpopulation)
%                          if omitted or NaN, 1.0 (100%) is assumed
%    ObjVCh    - (optional) Column vector containing the objective values
%                of the individuals (parents - Chrom) in the current 
%                population, needed for fitness-based insertion
%                saves recalculation of objective values for population
%    ObjVSel   - (optional) Column vector containing the objective values
%                of the offspring (SelCh) in the current population, needed for
%                partial insertion of offspring,
%                saves recalculation of objective values for population
%
% Output parameters:
%    Chrom     - Matrix containing the individuals of the current
%                population after reinsertion.
%    ObjVCh    - if ObjVCh and ObjVSel are input parameter, than column 
%                vector containing the objective values of the individuals
%                of the current generation after reinsertion.
           
% Author:     Hartmut Pohlheim
% History:    10.03.94     file created
%             19.03.94     parameter checking improved

function [Chrom, ObjVCh] = reins_age(Chrom, SelCh, SUBPOP, InsOpt, ObjVCh, ObjVSel)


    [NIND, ~] = size(Chrom);
    [NSEL, ~] = size(SelCh);
    IsObjVCh = 0; IsObjVSel = 0;
    if nargin > 4, 
        [mO, nO] = size(ObjVCh);
        if nO ~= 1, error('ObjVCh must be a column vector'); end
        IsObjVCh = 1;
    end
    if nargin > 5, 
        [mO, nO] = size(ObjVSel);
        if nO ~= 1, error('ObjVSel must be a column vector'); end
        IsObjVSel = 1;
    end
    
    isodd = mod(NIND,2);
    half = uint64(NIND/2);
    PopIx = 1:half;
    % Calculate position of Nins-% best offspring
    if (half < NSEL),  % select best offspring
        [Dummy, SelIx] = sort(ObjVSel(1:NSEL));
        SelIx = SelIx((1:half));
    else              
        SelIx = (1:half);
    end
    
    % Insert offspring in subpopulation -> new subpopulation
    PopIx2 = (half+1-isodd):NIND;
    Chrom(PopIx2,:) = Chrom(PopIx,:);
    Chrom(PopIx,:) = SelCh(SelIx,:);
    if (IsObjVCh == 1 & IsObjVSel == 1)
        ObjVCh(PopIx2) = ObjVCh(PopIx);
        ObjVCh(PopIx) = ObjVSel(SelIx);
    end
end


% End of function
