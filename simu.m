function y=simu(h,la,q,N)
    x = zeros(N,1);
    for i= 1:N
        r = neutron(h,la,q);
        x(i) = r;
    end
    y = zeros(3,1);
    for i=1:3
        y(i) = length(x(x == i-2));
    end
    y = y/N;
end
    