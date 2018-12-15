% T  - Anzahl der betrachteten Tage
% x0 - Parameter der Paretoverteilung (und damit der Schadensh�he)
% la - Parameter der Exponentialverteilung (f�r die Dauer bis zum n�chsten Schaden)
% c  - T�gliche Einnahmen
% c0 - Startkapital
% N  - Anzahl der Realisierungen
%----------
% Plottet verchiedene k gegen die Ruinwahrscheinlichkeit
function kspace(T,x0,la,c,c0,N)
    y = zeros(1,100);
    %Zwischen 0.25 und 5
    k = linspace(0.25,5,100);
    for i = 1:100
        %Simulieren der Wahrscheinlichkeit
        y(i) = 100*ruin(T,k(i),x0,la,c,c0,N);
    end
    %Plot
    title("Ruinwahrscheinlichkeit")
    xlabel("k")
    ylabel("p in %")
    hold on
    plot(k,y);
end