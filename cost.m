function c = cost(Y,X,Q)
    [~,~,k] = size(Y);
    c = 1/k * norm(X - pagemtimes(Y,Q),"fro")^2;
end