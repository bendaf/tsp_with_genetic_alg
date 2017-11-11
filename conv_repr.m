

function Chrom = convert_repr(Chrom, reprFrom, reprTo)
    switch reprFrom
        case 1
            switch reprTo
                case 2
                    Chrom = path2adj(Chrom);
                case 3
            end
        case 2
            switch reprTo
                case 1
                    Chrom = adj2path(Chrom);
                case 3
            end
        case 3
    end
end