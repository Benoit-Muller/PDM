function [B,Bcost,info] = cvx_solve(A)
[n,~,k] = size(A);
Asqrt=multisqrtm(A);
diagAsqrt = zeros(n*k);
for j=1:k
    ids = (j-1)*n + (1:n);
    diagAsqrt(ids,ids) = Asqrt(:,:,j);
end
trA = sum(multitrace(A));

cvx_begin sdp quiet
    variable B( n, n ) symmetric
    dual variable D
    minimize(k*trace(B) + trA - 2*trace_sqrtm(diagAsqrt * kron(eye(k),B) * diagAsqrt))
    B >= 0 : D;
cvx_end

Bcost=cvx_optval;
info.cvx_status=cvx_status;
info.cvx_slvitr=cvx_slvitr;
info.cvx_slvtol=cvx_slvtol;
info.cvx_optbnd=cvx_optbnd;
info.cvx_cputime=cvx_cputime;
end