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
    problem.egrad = @(Z) Qt_field_g(egrad(problem.Y, Z.X, multitransp(Z.Qt)));
    %problem.costgrad = @(Z) costgrad(problem.Y, Z.X, multitransp(Z.Qt));
    problem.ehess = @(Z,W) problem.egrad(W);
    %problem.variance = @(B) cost_variance(problem.A,B);
    %problem.egrad_variance = @(B) egrad_variance(problem.A,B);
end

function Znew = Qt_field_g(Z)
    Znew.X = Z.X;
    Znew.Qt = multitransp(Z.Q);
end

    