function Y = multisqrtm(A,r)
% return Y such that Y*Y'=A. if r is not specified, return the unique psd
% matrix. If not, it return a low rank factorization of width r.
    [n,~,k] = size(A);
    if nargin==1
        r=n;
    end
    Y = zeros(n,r,k);
    for j=1:k
        [V,D] = eigs(A(:,:,j),r);
        V=real(V);
        D=real(D);
        D(D<0)=0;
        if r==n
            Y(:,:,j) = V * sqrt(D) * V';
            Y(:,:,j)= 0.5*(Y(:,:,j) + multitransp(Y(:,:,j)));
        else
            Y(:,:,j) = V * sqrt(D);
        end
    end
end