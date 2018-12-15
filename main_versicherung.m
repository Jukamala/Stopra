%Demonstriere die Funktionen
function main_versicherung()

    %Aufgabe 2
    %----------
    T = 360;
    k = 3;
    x0 = 100;
    la = 0.5;
    c = 75.25;
    c0 = 1000;
    
    %Simulation von 5 Risikoreserven
    figure(1)
    ruin(T,k,x0,la,c,c0,5,1,0,0,1);
    
    %Ruinwahrscheinlichkeit
    a = ruin(T,k,x0,la,c,c0,500000);
    "Die Ruinwahrscheinlichkeit ist " + a
    
    %Ruinwahrscheinlichkeit in Abhängigkeit von k
    figure(2)
    kspace(T,x0,la,c,c0,10000);
    pause(0.01)
    
    %Bedingte Wahrscheinlichkeit von RT < 0
    "RT < 0  bedingt auf Bankrot ist " + ruin(T,k,x0,la,c,c0,100000,0)
    
    %Lohnt sich die Rückversicherung?
    % -> Nein
    b = ruin(T,k,x0,la,c,c0,500000,1,1);
    "Die Ruinwahrscheinlichkeit mit Rückversicherung ist " + b + " > " + a + " (ohne)"
    
    %Ermitteln des benötigten Startkapitals
    %Zwischen 6500 und 7500
    varc = linspace(6500,7500,21);
    i = 0;
    y = 1;
    while(y > 0.005 && i < 21)
        i = i + 1;
        y = ruin(T,k,x0,la,c,varc(i),100000);
    end
    "Das mindestens benötigte Startkapital beträgt " + varc(i)
    
    %Ruinwahrscheinlichkeit mit Zinsen
    a = ruin(T,k,x0,la,c,c0,500000,1,0,1);
    b = ruin(T,k,x0,la,c,c0,500000,1,1,1);
    "Die Ruinwahrscheinlichkeit mit Rückversicherung ist " + b + " > " + a + " (ohne)"
    
end
