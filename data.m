function A = data(n,k,r)
    Y = randn(n,r,k);
    A = multiprod(Y,multitransp(Y));
    A= 0.5*(A+multitransp(A));
end