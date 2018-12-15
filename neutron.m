% Input:
% h - Dicke der Wand
% la - Faktor der Exponentialverteilung
% q - Wahrscheinlickeit der Absorption
% N - Anzahl Versuche
%
% optinal(Standard):
% plt(0) - Wird ein Plot angeziegt?
%          (0 - nein, 1 - 2D Plot)
%----------
% Output:
% y = [p(-),p(0),p(+)]^T - Wahrscheinlickeit der F‰lle
%----------
% Neutron simuliert den Neutronenbeschuss auf eine Wand mit den Paramtern
% h, la und q. Dieser Experiment wird N mal wiederholt.
% Intern berechnet das Programm dazu die n‰chsten Schritte und rechet aus
% ob inzwischen ein terminierendes Eriegnis eingetreten ist, dann
% wiederholt es mit allen nichtterminierten Versuchen solange weiter bis
% alle abgeschlossen sind.
function y = neutron(h,la,q,N,plt)
    %Standarm‰ﬂig kein Plot
    if nargin < 5
        plt = 0;
    end
    
    %Anzahl von +,0,-
    y = zeros(3,1);
    
    %Initialisieren
    N0 = N;
    s = zeros(3,N);
    %Ertser Schritt
    s(1,:) = 1;
    s = s .* repmat(reshape(expvert(la,N),[1,N]),[3,1]);
    
    if plt > 0
        %Farben initialisieren
        colors = repmat(get(gca,'colororder'),[ceil(N/7),1]);
        colors = colors(1:N,:);
        title("Neutronenbeschuss")
        xlabel("x")
        ylabel("y")
        hold on
        
        for i = 1:N
            plot([0,s(1,i)], [0,0],'Color',colors(i,:))
        end
    end
    
    %Solange die Simulation noch nicht fertig ist
    while(N > 0)
    
        %Generieren von Zufallsvektoren mit Richtung vereilt nach ballvert()
        %(Ausnahme: am Anfang [1,0,0]^T) und L‰nge verteilt nach expvert()
        %    dim 1 - Vektor
        %    dim 2 - n Verusche
        w = repmat(reshape(expvert(la,N),[1,N]),[3,1]);
        r = ballvert(N);
        z = w.*r;
        %neue Position der Neutronen
        z = s + z;
        
        %Plotten
        if plt > 0
            %2D Plot
            for i = 1:N
                plot([s(1,i),z(1,i)], [s(2,i),z(2,i)],'Color',colors(i,:))
            end
        end
        
        %Absorbieren
        a = (rand(1,N) <= q);
        y(2) = y(2) + sum(a);
        
        %Nichtabsorbierte Neutronen weitersimulieren
        z = z(repmat(a == 0,[3,1]));
        z = reshape(z,3,length(z)/3);
        %Austritt links und rechts
        l = z(1,:) <= 0;
        r = z(1,:) >= h;
        y(1) = y(1) + sum(l);
        y(3) = y(3) + sum(r);
        
        %Neuer Startvektor mit Neutronen, die noch weiter simuliert werden
        t = (l == 0 & r == 0);
        s = z(repmat(t,[3,1]));
        s = reshape(s,3,length(s)/3);
        N = size(s,2);
        
        if plt > 0
            %Farben updaten (damit sie im Plot sp‰ter gleich bleiben)
            colors = colors(repmat(t',[1,3]));
            colors = reshape(colors,length(colors)/3,3);
        end
    end
    y = y./N0;
end