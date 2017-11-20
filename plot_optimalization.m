function plot_optimalization(ptitle, X, Y, pxlabel, pylabel)
    figure;
    bar(Y)
    xlabel(pxlabel)
    ylabel(pylabel)
    title(ptitle)
    set(gca,'xticklabel',X);
end