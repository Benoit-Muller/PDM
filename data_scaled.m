function A = data_scaled(B,k)
% Generate data samples that follow a distribution whose BW barycenter is
% (suposedly) B.
    n = size(B,1);
    Z = randn(n,n,k);
    ZZt = Z*multitransp(Z);
    A = ZZt*B*ZZt;
    A = multisym(A); % numeric purposes
end