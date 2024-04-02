function c = cost_variance(A,B)
    [~,~,k] = size(A);
    X=sqrtm(B);
    c = 0;
    for j=1:k
        c = c - 2 * trace(sqrtm(X*A(:,:,j)*X));
        c = c + trace(A(:,:,j)) + trace(B);
    end
end