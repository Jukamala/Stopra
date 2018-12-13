function kspace(T,k,x0,la,c,c0,N)
    y = 1;
    %Alle Versuche
    k = linspace(0.25,5,100);
    for i = 1:100
        y(i) = 100*ruin(T,k(i),x0,la,c,c0,N);
    end
    %Plot
    title("Ruinwahrscheinlichkeit")
    xlabel("k")
    ylabel("p in %")
    hold on
    plot(k,y);
end