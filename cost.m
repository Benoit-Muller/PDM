function c = cost(Y,X,Q)
    [~,~,k] = size(Y);
    c = 1/k * norm(X - multiprod(Y,Q),"fro")^2;
end