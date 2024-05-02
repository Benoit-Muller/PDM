function Y = multisqrtm(A,r)
    [n,m,k] = size(A);
    if nargin==1
        r=n;
    end
    Y = zeros(n,m,k);
    for j=1:k
        [V,D] = eig(A(:,:,j));
        V=real(V);
        D=real(D);
        D(D<0)=0;
        if r==n
            Y(:,:,j) = V * sqrt(D) * V';
            Y(:,:,j)= 0.5*(Y(:,:,j) + multitransp(Y(:,:,j)));
        else
            Y(:,:,j) = V(:,1:r) * sqrt(D(1:r,1:r));
        end
    end
end