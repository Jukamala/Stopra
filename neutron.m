function y=neutron(h,la,q,plt)
    %Standarm‰ﬂig kein plot
    if nargin < 5
        plt = 0;
    end
    %Standarm‰ﬂig N = 1
    if nargin < 4
        N = 1;
    end
    
    %Startvektor 
    s = [0;0;0;1;0;0];
    sold = [s(1);s(2)];
    while(0 <= s(1) && s(1) < h)
        if rand(1) < q
            %disp("Absorbtion")
            y = 0;
            return
        end
        w = expvert(la,1);
        s(1:3) = w*s(4:6) + s(1:3);
        w = erzeugeU(1);
        s(4:6) = w;
        %Plotten von Linien
        if plt
            plot([s(1);sold(1)],[s(2);sold(2)])
            hold on
            sold = [s(1);s(2)];
        end
    end
    if s(1) < 0
        y = -1;
    else
        y = 1;
    end
end