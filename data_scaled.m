function A = data_scaled(B,k,version)
% Generate data samples that follow a distribution whose BW barycenter is B
% If version="exact", the empirical barycenter of data is also exactly B.
    n = size(B,1);
    Z = randn(n,n,k);
    C = 1/n * pagemtimes(Z,"none",Z,"transpose"); % Whishart
    % could be any distribution on psd matrices and with expectation I.
    if nargin==3 && version=="exact"
        [V,D]=eig(mean(C,3));
        correction = V*D^(-0.5)*V';
        C = pagemtimes(pagemtimes(correction,C),correction);
    end
    A =  pagemtimes(pagemtimes(C,B),C);
    A = multisym(A); % numeric purpose
end