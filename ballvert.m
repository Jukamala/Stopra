%Die Funktion zieht N Zuf�llige Vektoren auf einer 2-Sph�re
function x=ballvert(N)
    x=randn(3 ,N);
    x=x./( ones (3 ,1)*sum(x .^2).^(1/2));
end