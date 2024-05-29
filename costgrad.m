function [c,g] = costegrad(Y,X,Q)
    [~,~,k] = size(Y);
    X_YQ = X - pagemtimes(Y,Q);
    c = 1/k * norm(X_YQ,"fro")^2;
    g.X = 2/k * sum(X_YQ, 3);
    g.Q = 2/k * pagemtimes(multitransp(Y), -X_YQ);
end