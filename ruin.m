function y = ruin(T,k,x0,la,c,c0,N)
    time=zeros(N,1);
    K=zeros(N,1);
    K(:,:)=c0;
    m=N;
    
    Kend = [];
    hold on
    while(m>0)
        oldtime = time;
        oldK = K;
        resttime = expvert(la,m);
        time = time + resttime;
        
        mask = (time > T);
        time(mask) = T;
        K(mask)  = K(mask) + (T - time(mask)) * c;
        cost = polvert(x0,k,sum(mask == 0));
        K(mask == 0) = K(mask == 0) + c * resttime(mask==0);
        High = K;
        K(mask == 0) = K(mask == 0) - cost;
        
        for i = 1:m
            plot([oldtime(i),time(i),time(i)],[oldK(i),High(i),K(i)])
        end
        fertig = (mask | K<=0);
        Kend = cat(1,Kend,K(fertig));
        K = K(fertig == 0);
        time = time(fertig == 0);
        m = sum(fertig == 0);
    end
    y = Kend;
end
        