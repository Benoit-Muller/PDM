function g = egrad(Y,X,Q)
    [~,~,k] = size(Y);
    g.X = 2/k * sum(X - multiprod(Y,Q), 3);
    g.Q = 2/k * multiprod(multitransp(Y), multiprod(Y,Q) - X);
end