function c = cost_variance(A,B)
    [~,~,k] = size(A);
    Bsqrt=multisqrtm(B);
    c = 0;
    for j=1:k
        E = eig(Bsqrt*A(:,:,j)*Bsqrt);
        E(E<0)=0;
        c = c - 2 * sum(sqrt(E));
        c = c + trace(A(:,:,j)) + trace(B);
    end
    c=c/k;
end