function c = cost(Y,X,Q)
    c = norm(X - multiprod(Y,Q),"fro")^2;
end