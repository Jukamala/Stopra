%Demonstriere die Funktionen 26.85
function main()

    % Aufagbe 1
    %----------
    
    la = 1.1235;
    q = 0.010414;
    
    %Plotten 5 Neutronen bei h = 25
    figure(1)
    neutron(25,la,q,5,5,1)
    
    %Plot der Wahrscheinlichkeiten für variable Höhe
    % siehe auch bleiwand_dicke.fig
    figure(2)
    dicke(la,q,10000)
    
    %Ablesen und probieren ergibt einen Wert von ~26.85 cm
    y = neutron(26.85,la,q,1000000);
    abs(y(3) - 0.01)
    
    %Plot der Eintrittstiefe für h = 10 cm
    siehe auch bleiwand_eintritt.fig
    figure(3)
    %yvert(10,la,q,10000)
    
end