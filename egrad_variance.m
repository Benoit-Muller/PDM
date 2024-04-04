function g = egrad_variance(A,B)
    [n,~,k] = size(A);
    X = sqrtm(B);
    X = 0.5*(X + X'); % numerical need
    g = eye(n);
    for j=1:k
        g = g - 1/k * X \ sqrtm(X*A(:,:,k)*X) / X;
    end
end