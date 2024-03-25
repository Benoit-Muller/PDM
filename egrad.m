function g = egrad(Y,X,Q)
    g.E = 2 * sum(X - multiprod(Y,Q), 3);
    g.O = 2 * multiprod(Y, multiprod(Y,Q) - X);
end