function y=dick(la,q)
    y = zeros(3,50);
    for h = 1:50
        y(:,h) = simu(h,la,q,10);
    end
    plot(1:50,y(1,:))
    plot(1:50,y(2,:))
    plot(1:50,y(3,:))
end