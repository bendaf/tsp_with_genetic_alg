function plot_optimalization(ptitle, X, Y, pxlabel, pylabel)
    figure;
    plot(X,Y)
    xlabel(pxlabel)
    ylabel(pylabel)
    title(ptitle)
    legend('inversion','insertion');
end