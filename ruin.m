% T  - Anzahl der betrachteten Tage
% k, x0 - Parameter der Paretoverteilung (und damit der Schadenshöhe)
% la - Parameter der Exponentialverteilung (für die Dauer bis zum nächsten Schaden)
% c  - Tägliche Einnahmen
% c0 - Startkapital
% N  - Anzahl der Realisierungen
%
% optional(Standard):
% bank(1) - ist Bankrott final (also werden bankrotte Realisierungen weiter modelliert?)
% 		    (0 - weiter modellieren, 1 - abbrechen)
% vers(0) - gibt es die Rückversicherung? (0 - nein, 1 - ja)
% zins(0) - sind Zinsen zu zahlen? (0 - nein, 1 - ja)
% plt(0)  - wird ein Plot der Kapitalverläufe erstellt? (0 - nein, 1 - ja)
%----------
% Output:
% y - Ruinwahrscheinlichkeit (Bankrot) falls bank = 1
%   - P(RT < 0) bedingt auf Ruin       falls bank = 0
%----------
% Ruin simuliert den Verlauf der Risikoreserven N Versicherungen mit
% exponentialverteilten Abständen zwischen patroverteilten Schadenshöhen
% Optional kann der Bankrott, eine Rückversicherung oder Zinsen
% berücksichtigt werden und ein Plot gezeigt werden
function [y] = ruin(T,k,x0,la,c,c0,N,bank,vers,zins,plt)
    %Standardmäßig bankrott möglich, keine Rückversicherung/Zinsen
    if nargin < 8
        bank = 1;
    end
    if nargin < 9
        vers = 0;
    end
    if nargin < 10
        zins = 0;
    end
    %Standardmäßig kein Plot
    if nargin < 11
        plt = 0;
    end
    
    if plt > 0
        %Farben initialisieren
        colors = repmat(get(gca,'colororder'),[ceil(N/7),1]);
        colors = colors(1:N,:);
        title("Risikoreserve")
        xlabel("t in Tagen")
        ylabel("Reserve in Euro")
        
        hold on
    end
    
    %Kosten...
    % - des Zines
    if zins == 1
        c = c - 0.08*c0/360;
    end
    % - der Versicherung
    if vers == 1
        c = c - 750/360;
    end
    
    %Initialisieren
    time = zeros(N,1);
    K = zeros(N,1);
    K(:,:) = c0;
    %Anzahl der noch zu simulierenden Versicherungen
    m = N;
    
    %Anzahl Ruine
    if(bank == 0)
        bankrot = zeros(N,1);
        BankrotEnd = [];
    end
    
    Kend = [];
    
    %Solange die Simulation noch nicht fertig ist
    while(m > 0)
        
        %Werte speichern für Plot
        if plt > 0
            oldtime = time;
            oldK = K;
        end
        
        %Nächster Schadensfall
        nexttime = expvert(la,m);
        time = time + nexttime;
        
        %Stellen an denen T Tage verstrichen sind
        mask = (time > T);
        time(mask) = T;
        %Berechne das Kapital beendeter Simulationen
        K(mask)  = K(mask) + (T - time(mask)) * c;
        cost = polvert(x0,k,sum(mask == 0));
        %Hohe Kosten werden auf 1000 gesenkt
        if vers
            cost( cost > 1000) = 1000;
        end
        %Berechnen des Kapitals noch laufender Simulationen
        K(mask == 0) = K(mask == 0) + c * nexttime(mask==0);
        High = K;
        K(mask == 0) = K(mask == 0) - cost;
        
        %Plot
        if plt > 0
            for i = 1:m
                plot([oldtime(i),time(i),time(i)],[oldK(i),High(i),K(i)],"Color",colors(i,:))
                hold on
            end
            %Dynamischer Plot 
            pause(0.00001)
            xlabel("t in Tagen")
            tmax = max(time);
            plot([0,tmax*1.1],[0,0],'red');
            xlim([0,tmax*1.1])
        end
        
        %Eventuelles Löschen bankrotter Versicherungen für die weiter
        %Simulation
        if bank
            fertig = (mask | K<=0);
        else
            fertig = mask;
            bankrot( K <= 0 ) = 1;
            BankrotEnd = cat(1,BankrotEnd,bankrot(fertig));
            bankrot = bankrot(fertig == 0);
        end
        
        if plt > 0
            %Farben updaten (damit sie im Plot später gleich bleiben)
            colors = colors(repmat((fertig == 0)',[1,3]));
            colors = reshape(colors,length(colors)/3,3);
        end
        
        %Anpassen von K und time und speichern des Endkapitals
        Kend = cat(1,Kend,K(fertig));
        K = K(fertig == 0);
        time = time(fertig == 0);
        m = sum(fertig == 0);
    end
    
    %Rückgabe
    if bank == 0
        y = sum(Kend < 0)/sum(BankrotEnd);
    else
        y = sum(Kend < 0)/N;
    end
end
        