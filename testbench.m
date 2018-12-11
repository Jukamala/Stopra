function testbench(h,la,q,n,k)
    n = repmat(n,[2,1]);
    l = repmat("",[1,length(k)]);
    hold on
    for i = 1:size(k,2)
        for j = 1:size(n,2)
            f = @() neutron(h,la,q,n(1,j),k(i));
            n(2,j) = timeit(f)
        end
        loglog(n(1,:),n(2,:));
        l(i) = ("k = " + k(i));
    end
    legend(l)
    
end