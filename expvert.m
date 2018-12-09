% N Exponentialverteilte Werte
function y = expvert(la,N)
    y = -la*log(1 - rand(N,1));
    %histogram(y,200);
end
    