function X = multisqrtm(A)
    [n,m,k] = size(A);
    X = zeros(n,m,k);
    for j=1:k
        [V,D] = eig(A(:,:,j));
        V=real(V);
        D=real(D);
        D(D<0)=0;
        X(:,:,j) = V*sqrt(D)*V';
        X(:,:,j)= 0.5*(X(:,:,j)+multitransp(X(:,:,j)));
    end
end