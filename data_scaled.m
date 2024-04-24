function A = data_scaled(B,k)
% Generate data samples that follow a distribution whose BW barycenter is
% (suposedly) B.
    n = size(B,1);
    Z = randn(n,n,k);
    ZZt = pagemtimes(Z,"none",Z,"transpose");
    A = 1/n^2 * pagemtimes(pagemtimes(ZZt,B),ZZt);
    A = multisym(A); % numeric purpose
end