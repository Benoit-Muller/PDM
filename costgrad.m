function [c,g] = costgrad(Y,X,Q)
    X_YQ = X - multiprod(Y,Q);
    c = norm(X_YQ,"fro")^2;
    g.X = 2 * sum(X_YQ, 3);
    g.Q = 2 * multiprod(multitransp(Y), -X_YQ);
    g.Q = g.Q - multiprod(Q,multisym(multiprod(multitransp(Q),g.Q)));
end