%Die Funktion zieht eine Realsierung N Paretoverteilter Zufallsvariablen
% mit Parametern k und x0
function y = polvert(x0, k, N)
    y = x0 ./ ((1 - rand(N,1)).^(1/k));
end


