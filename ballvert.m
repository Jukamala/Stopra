%Die Funktion zieht N Zufällige Vektoren auf einer 2-Sphäre
function x=ballvert(N)
    x=randn(3 ,N);
    x=x./( ones (3 ,1)*sum(x .^2).^(1/2));
end