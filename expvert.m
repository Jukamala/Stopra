%Die Funktion zieht eine Realsierung N Exponentialverteilter Zufallsvariablen
% mit Parameter la
function y = expvert(la,N)
    y = -(1/la)*log(1 - rand(N,1));
    %histogram(y,200);
end
    