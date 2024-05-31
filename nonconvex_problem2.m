function problem = nonconvex_problem2(A,r,p)
% r >= p
    [n,n,k] = size(A);
    problem.n=n;
    problem.r=r;
    problem.p=p;
    problem.k=k;
    problem.A = A;

    problem.M = stiefelstackedfactory(k,r,p);

    problem.Y3 = zeros(n,r,k);
    for i=1:k
        [V,D] = eigs(A(:,:,i),r); %eigs
        problem.Y3(:,:,i) = V*sqrt(D);
    end
    problem.Y2 = problem.M.to2D(Y3);

    problem.chi = @(Q) 1/k * Q*problem.Y2;
    normY = norm(Y2,"fro");
    problem.cost = @(Q) -1/k^2 * norm(problem.Y2*Q,"fro") + 1/k*normY;

    problem.egrad = @(Q) -2/k^2 * problem.Y2' * (problem.Y2 * Q);

    problem.costgrad = @costgrad;
    function [c,g] = costgrad(Q)
        Y2Q = problem.Y2*Q;
        c = -1/k^2 * norm(Y2Q,"fro") + 1/k*normY;
        g = -2/k^2 * problem.Y2' * Y2Q;
        g = M.egrad2rgrad(g);
    end

    problem.ehess = @(Q,v) problem.egrad(V);
    problem.B =@()
    problem.variance = @(B) cost_variance(problem.A,B);
    problem.egrad_variance = @(B) egrad_variance(problem.A,B);
end