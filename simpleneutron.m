%Ptimiert für k = 1
function y = simpleneutron(h,la,q,n,plt)
    %Standarmäßig kein Anfang
    if nargin < 5
        plt = 0;
    end
    
    %Anzahl von +,0,-
    y = zeros(3,1);
    
    %Initialisieren
    n0 = n;
    s = zeros(3,n);
    %Ertser Schritt
    s(1,:) = 1;
    s = s .* repmat(reshape(expvert(la,n),[1,n]),[3,1]);
    
    if plt > 0
        %Farben initialisieren
        colors = repmat(get(gca,'colororder'),[ceil(n/7),1]);
        colors = colors(1:n,:);
        title("Neutronenbeschuss")
        xlabel("x")
        ylabel("y")
        hold on
    end
    
    while(n > 0)
    
        %Generieren von Zufallsvektoren mit Richtung vereilt nach ballvert()
        %(Ausnahme: am Anfang [1,0,0]^T) und Länge verteilt nach expvert()
        %    dim 1 - Vektor
        %    dim 2 - n Verusche
        w = repmat(reshape(expvert(la,n),[1,n]),[3,1]);
        r = ballvert(n);
        z = w.*r;
        %neue Vektoren
        z = s + z;
        
        %Plotten
        if plt > 0
            %2D Plot
            if plt == 1
                for i = 1:n
                    plot([s(1,i),z(1,i)], [s(1,2),z(1,2)],'Color',colors(i,:))
                end
            end
        end
        
        %Absorbieren
        a = (rand(1,n) <= q);
        y(2) = y(2) + sum(a);
        
        %Mit dem Rest weiter machen
        z = z(repmat(a == 0,[3,1]));
        z = reshape(z,3,length(z)/3);
        %Austritt links und rechts
        l = z(1,:) <= 0;
        r = z(1,:) >= h;
        y(1) = y(1) + sum(l);
        y(3) = y(3) + sum(r);
        
        %neuer Startvektor wo Simulation noch nicht fertig ist
        t = (l == 0 & r == 0);
        s = z(repmat(t,[3,1]));
        s = reshape(s,3,length(s)/3);
        n = size(s,2)
        
        if plt > 0
            %Farben updaten (damit sie im Plot später gleich bleiben)
            colors = colors(repmat(t',[1,3]));
            colors = reshape(colors,length(colors)/3,3);
        end
    end
    y = y./n0;
end