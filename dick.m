function y=dick(la,q,N)
    y = zeros(3,1);
    h = linspace(0.01,50,100);
    for i = 1:100
        y(:,i) = neutronblock(h(i),la,q,N)./N;
    end
    title("Ereignisse")
    xlabel("h in cm")
    ylabel("p in %")
    l1 = "linker Austritt";
    l2 = "Absorption";
    l3 = "rechter Austritt";
    hold on
    a1 = plot(h,y(1,:));
    a2 = plot(h,y(2,:));
    a3 = plot(h,y(3,:));
    legend([a1;a2;a3],l1,l2,l3)
end