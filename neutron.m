function y=neutron(h,la,q)
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
        plot([s(1);sold(1)],[s(2);sold(2)])
        hold on
        sold = [s(1);s(2)];
    end
    if s(1) < 0
        y = -1;
    else
        y = 1;
    end
end