function g = egrad(Y,X,Q)
    g.X = 2 * sum(X - multiprod(Y,Q), 3);
    g.Qt = 2 * multitransp(multiprod(multitransp(Y), multiprod(Y,Q) - X));
end