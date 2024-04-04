function [c,g] = costgrad(Y,X,Q)
    [~,~,k] = size(Y);
    X_YQ = X - multiprod(Y,Q);
    c = 1/k * norm(X_YQ,"fro")^2;
    g.X = 2/k * sum(X_YQ, 3);
    g.Qt = 2/k * multiprod(multitransp(Y), -X_YQ);
    g.Qt = g.Qt - 1/k * multiprod(Q,multisym(multiprod(multitransp(Q),g.Qt)));
    g.Qt = multitransp(g.Qt);
end