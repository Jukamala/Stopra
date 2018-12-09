% Input:
% h0 - Dicke der zu untersuchenden Wand
% la - Faktor der Exponentialverteilung
% q - Wahrscheinlickeit der Absorption
% N - Anzahl der Experimente pro Datenpunkt
%----------
% Berechnet für 100 äquidistante Punkte bis h0 die Wahrscheinlichkeit das
% ein Elektron nicht weiter als x gekommen ist, diese Wahrscheinlichkeit
% entspricht "1 - p(+)" bei einem Versuch mit entsprechender Breite der
% Wand h = x
function yvert(h0,la,q,N)
    y = 0;
    h = linspace(0.01,h0,100);
    for i = 1:100
        %1-p(+) für h = x
        z = neutron(h(i),la,q,N);
        y(i) = 1 - z(3);
    end
    %Plot
    title("Wahrscheinlickeit eines Eintritts bis maximal x cm bei einer Wand der Breite " + h0)
    xlabel("x in cm")
    ylabel("p in %")
    hold on
    plot(h,y);
end