% bank - Können Versicherungen bankrott gehen?
% vers - Soll nur Beträge > 1000 bezahlt werden (anders)
%----------
% y - Ruinwahrscheinlichkeit (Bankrot)
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
    close all
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
    
    time=zeros(N,1);
    K=zeros(N,1);
    K(:,:)=c0;
    m=N;
    
    %Anzahl Ruin
    if(bank == 0)
        bankrot = zeros(N,1);
        BankrotEnd = [];
    end
    
    Kend = [];
    
    while(m>0)
        %Werte speichern für Plot
        if plt > 0
            oldtime = time;
            oldK = K;
        end
        
        
        resttime = expvert(la,m);
        time = time + resttime;
        
        mask = (time > T);
        time(mask) = T;
        K(mask)  = K(mask) + (T - time(mask)) * c;
        cost = polvert(x0,k,sum(mask == 0));
        %Hohe Kosten werden auf 1000 gesenkt
        if vers
            cost( cost > 1000) = 1000;
        end
        K(mask == 0) = K(mask == 0) + c * resttime(mask==0);
        High = K;
        K(mask == 0) = K(mask == 0) - cost;
        if plt > 0
            for i = 1:m
                plot([oldtime(i),time(i),time(i)],[oldK(i),High(i),K(i)],"Color",colors(i,:))
                hold on
            end
            pause(0.00001)
            xlabel("t in Tagen  Verbleibende: " + m)
            tmax = max(time);
            plot([0,tmax*1.1],[0,0],'red');
            
        
        end
        
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
        
        Kend = cat(1,Kend,K(fertig));
        K = K(fertig == 0);
        time = time(fertig == 0);
        m = sum(fertig == 0);
        if plt > 0
            m
        end
    end
    
    if bank == 0
        y = sum(Kend < 0)/sum(BankrotEnd);
    else
        y = sum(Kend < 0)/N;
    end
end
        