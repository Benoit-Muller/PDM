function A = data(n,k,r)
%  k random positive semidefinite nxn-matrices of rank r
% size(A) = [n,r,k]
    Y = randn(n,r,k);
    A = multiprod(Y,multitransp(Y));
    A= 0.5*(A+multitransp(A));
end