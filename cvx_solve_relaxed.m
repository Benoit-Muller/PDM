function [B,Bcost,info] = cvx_solve_relaxed(A,r)
    [n,~,k]=size(A);
    if nargin==1
        r=n;
    end
    Y3=multisqrtm(A,r);
    Y2=reshape(multitransp(Y3), [n, r*k]);
    
    cvx_begin sdp quiet
        variable S( r*k, r*k ) symmetric
        YS=Y2*S;
        minimize(-Y2(:)' * YS(:))
        S >= 0;
        for j=1:k
            ids = (j-1)*r+(1:r);
            S(ids,ids)==eye(r);
        end
    cvx_end
    
    B=1/k^2 *Y2*S*Y2';
    Bcost=cvx_optval;
    info.cost = cvx_optval;
    info.status = cvx_status;
    info.iter = cvx_slvitr;
    info.tol = cvx_slvtol;
    info.optbnd = cvx_optbnd;
    info.time = cvx_cputime;
    info.S=S;
end