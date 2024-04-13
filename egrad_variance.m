function g = egrad_variance(A,B)
    [n,~,k] = size(A);
    Bsqrt = multisqrtm(B);
    g = eye(n);
    for j=1:k
        g = g - 1/k * (Bsqrt \ multisqrtm(Bsqrt*A(:,:,j)*Bsqrt)) / Bsqrt;
    end
end