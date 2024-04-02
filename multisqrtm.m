function X = multisqrtm(A)
    [n,m,k] = size(A);
    X = zeros(n,m,k);
    for j=1:k
        X(:,:,j) = sqrt(A(:,:,j));
    end
end