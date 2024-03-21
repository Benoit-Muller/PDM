function g = egrad(Y,X,Q)
    g.E = sum(X - multiprod(Y,Q), 3);
    g.O = multiprod(Y, multiprod(Y,Q) - X);
end