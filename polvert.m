function y = polvert(x0, k, N)
    y = x0 ./ ((1 - rand(N,1)).^(1/k));
end


