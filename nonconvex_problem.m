function problem = nonconvex_problem(A,r,p)
% r >= p
    [n,n,k] = size(A);
    problem.n=n;
    problem.r=r;
    problem.p=p;
    problem.k=k;

    problem.A = A;
    problem.Y = zeros(n,r,k);
    for i=1:k
        [V,D] = eigs(A(:,:,i),r); %eigs
        problem.Y(:,:,i) = V*sqrt(D);
    end

    problem.cost = @(Z) cost(problem.Y, Z.X, multitransp(Z.Qt));
    problem.M = euclidean_orthogonal_factory(n,r,p,k);

    problem.egrad = @egrad_transp;
    function g = egrad_transp(Z)
        g0 = egrad(problem.Y, Z.X, multitransp(Z.Qt));
        g.X=g0.X;
        g.Qt = multitransp(g0.Q);
    end

    problem.costgrad = @costgrad;
    function [c,g] = costgrad(Z)
        [c,ge] = costegrad(problem.Y, Z.X, multitransp(Z.Qt));
        ge.Qt = multitransp(ge.Q);
        g = problem.M.egrad2rgrad(Z,ge);
    end

    problem.ehess = @(Z,W) problem.egrad(W);
    problem.variance = @(B) cost_variance(problem.A,B);
    problem.egrad_variance = @(B) egrad_variance(problem.A,B);
end

    