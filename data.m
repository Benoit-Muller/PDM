function A = data(n,k,r)
    Y = rand(n,r,k);
    A = multiprod(Y,multitransp(Y));
end