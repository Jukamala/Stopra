function x=erzeugeU(N)
    x=randn(3 ,N);
    x=x./( ones (3 ,1)*sum(x .^2).^(1/2));
    
end