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
    %ruin(T,k,x0,la,c,c0,5,1,0,0,1);
    
    %Ruinwahrscheinlichkeit
    a = ruin(T,k,x0,la,c,c0,1000000);
    "Die Ruinwahrscheinlichkeit ist " + a
    
    %KKK
    %kspace(T,k,x0,la,c,c0,10000);
    
    %Bedingte Wahrscheinlichkeit von RT < 0
    %"RT < 0  bedingt auf Bankrot ist " + ruin(T,k,x0,la,c,c0,100000)
    
    %Lohnt sich die Rückversicherung?
    % -> Nein
    b = ruin(T,k,x0,la,c,c0,1000000,1,1,0);
    "Die Ruinwahrscheinlichkeit mit Rückversicherung ist " + b
    
    %
    
    
end
