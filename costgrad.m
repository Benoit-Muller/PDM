function [c,g] = costgrad(Y,X,Q)
    X_YQ = X - multiprod(Y,Q);
    c = norm(X_YQ,"fro")^2;
    g.X = 2 * sum(X_YQ, 3);
    g.Qt = 2 * multiprod(multitransp(Y), -X_YQ);
    g.Qt = g.Qt - multiprod(Q,multisym(multiprod(multitransp(Q),g.Qt)));
    g.Qt = multitransp(g.Qt);
end