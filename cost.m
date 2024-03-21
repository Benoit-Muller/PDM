function c = cost(Y,X,Q)
    norm(X - multiprod(Y,Q),"fro")
end