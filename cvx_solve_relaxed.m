function [B,Bcost,info] = cvx_solve_relaxed(A)
    [n,k]=size(A);
    Y3=multisqrtm(A);
    Y2=reshape(multitransp(Y), [n, r*k]);
    
    cvx_begin sdp
        variable S( n*k, n*k ) symmetric
        YS=Y*S;
        minimize(-Y(:)' * YS(:))
        S >= 0;
        for j=1:k
            ids = (j-1)*n+(1:n);
            S(ids,ids)==eye(n);
        end
    cvx_end