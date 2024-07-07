function [B,Bcost,info] = cvx_solve(A,version)
    if nargin==1 || version == "fast"
        [B,Bcost,info] = cvx_solve_fast(A);
    elseif version=="slow"
        [B,Bcost,info] = cvx_solve_slow(A);
    end
end

function [B,Bcost,info] = cvx_solve_fast(A)
    [n,~,k] = size(A);
    Asqrt=multisqrtm(A);
    diagAsqrt = zeros(n*k);
    for j=1:k
        ids = (j-1)*n + (1:n);
        diagAsqrt(ids,ids) = Asqrt(:,:,j);
    end
    trA = sum(multitrace(A));
    % The convex problem:
    cvx_begin sdp quiet
        variable B( n, n ) symmetric
        cost = trace(B) + trA/k;
        for j=1:k
            cost = cost - 2/k * trace_sqrtm(Asqrt(:,:,j) * B * Asqrt(:,:,j));
        end
        minimize(cost)
        B >= 0
    cvx_end
    
    Bcost=cvx_optval;
    info.cost = cvx_optval;
    info.status = cvx_status;
    info.iter = cvx_slvitr;
    info.tol = cvx_slvtol;
    %info.optbnd = cvx_optbnd;
    info.time = cvx_cputime;
%     if info.status~="Solved"
%         warning(info.status)
%     end
end


function [B,Bcost,info] = cvx_solve_slow(A)
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
        minimize(trace(B) + trA/k - 2/k*trace_sqrtm(diagAsqrt * kron(eye(k),B) * diagAsqrt))
        B >= 0
    cvx_end
    
    Bcost=cvx_optval;
    info.cost = cvx_optval;
    info.status = cvx_status;
    info.iter = cvx_slvitr;
    info.tol = cvx_slvtol;
    info.optbnd = cvx_optbnd;
    info.time = cvx_cputime;
end