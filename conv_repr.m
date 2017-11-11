

function Chrom = conv_repr(Chrom, reprFrom, reprTo)
    switch reprFrom
        case 1
            switch reprTo
                case 2
                    Chrom = path2adj(Chrom);
                case 3
                    Chrom = path2ord(Chrom);
            end
        case 2
            switch reprTo
                case 1
                    Chrom = adj2path(Chrom);
                case 3
                    Chrom = path2ord(adj2path(Chrom));
            end
        case 3
            switch reprTo
                case 1
                    Chrom = ord2path(Chrom);
                case 2
                    Chrom = path2adj(ord2path(Chrom));
            end
    end
end