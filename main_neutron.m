%Demonstriere die Funktionen
function main_neutron()
    
    % Aufagbe 1
    %----------
    la = 1.1235;
    q = 0.010414;
    
    %Plotten 5 Neutronen bei h = 25
    figure(1)
    neutron(25,la,q,5,1)
    pause(0.01)
    
    %Plot der Wahrscheinlichkeiten für variable Dicke
    % siehe auch bleiwand_dicke.fig
    figure(2)
    dicke(la,q,50000)
    pause(0.01)
    
    % Für h = 0.3,1.9,48
    disp("h = 0.3 - p = ");
    neutron(0.3,la,q,500000)
    disp("h = 1.9 - p = ");
    neutron(1.9,la,q,500000)
    disp("h = 48 - p = ");
    neutron(48,la,q,500000)
    
    %Ermitteln der benötigten Dicke
    %Zwischen 19 und 20
    h = linspace(19,20,21);
    i = 0;
    y = [1;1;1];
    while(y(3)  > 0.01 && i <= 21)
        i = i + 1;
        y = neutron(h(i),la,q,100000);
    end
    "Die minimale Dicke beträgt " + h(i)
    
    %Plot der Eintrittstiefe für h = 10 cm
    % siehe auch bleiwand_eintritt.fig
    figure(3)
    yvert(10,la,q,50000)
    
end