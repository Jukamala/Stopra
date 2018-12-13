% bank - Können Versicherungen bankrott gehen?
% vers - Soll nur Beträge > 1000 bezahlt werden (anders)
function y = ruin(T,k,x0,la,c,c0,N,bank,vers,plt)
    if nargin < 8
        bank = 1
    if nargin < 9
        vers = 0;
    end
    %Standardmäßig kein Plot
    if nargin < 10
        plt = 0;
    end
    close all
    if plt > 0
        hold on
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
        K(mask == 0) = K(mask == 0) + c * resttime(mask==0);
        High = K;
        K(mask == 0) = K(mask == 0) - cost;
        if plt > 0
            for i = 1:m
                plot([oldtime(i),time(i),time(i)],[oldK(i),High(i),K(i)])
                hold on
            end
        end
        
        if bank
            fertig = (mask | K<=0);
        else
            fertig = mask;
            bankrot( K <= 0 ) = 1;
            BankrotEnd = cat(1,BankrotEnd,bankrot(fertig));
            bankrot = bankrot(fertig == 0);
        end
        Kend = cat(1,Kend,K(fertig));
        K = K(fertig == 0);
        time = time(fertig == 0);
        m = sum(fertig == 0)
    end
    
    y = Kend;
end
        