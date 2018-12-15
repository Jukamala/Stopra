% Input:
% h - Dicke der Wand
% la - Faktor der Exponentialverteilung
% q - Wahrscheinlickeit der Absorption
% N - Anzahl der Experimente pro Datenpunkt
%----------
% Berechnet für 100 äquidistante Punkte die Wahrscheinlichkeiten aller
% Ereignisse und plottet diese dann - die Genauigkeit hängt von der Anzahl
% der Versuche pro Punkt ab
function dicke(la,q,N)
    y = zeros(3,1);
    h = linspace(0.01,50,100);
    for i = 1:100
        %Simulieren der Wahrscheinlichkeit
        y(:,i) = neutron(h(i),la,q,N);
    end
    %Plot
    title("Ereignisse")
    xlabel("h in cm")
    ylabel("p")
    l1 = "Reflexion";
    l2 = "Absorption";
    l3 = "Transmission";
    hold on
    a1 = plot(h,y(1,:));
    a2 = plot(h,y(2,:));
    a3 = plot(h,y(3,:));
    legend([a1;a2;a3],l1,l2,l3)
end