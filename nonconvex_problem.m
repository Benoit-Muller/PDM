function problem = nonconvex_problem(A,r,p)
    [n,n,k] = size(A);
    problem.n=n;
    problem.r=r;
    problem.p=p;
    problem.k=k;

    problem.A = A;
    problem.Y = zeros(size(A));
    for i=1:k
        [U,S,V] = svds(A(:,:,i),r);
        problem.Y(:,:,i) = U*sqrt(S)*V';
    end
    problem.cost = @(Z) cost(problem.Y, Z.X, Z.Q);
    problem.M = euclidean_orthogonal_factory(n,r,p,k);
    problem.egrad = @(Z) egrad(problem.Y, Z.X, Z.Q);
    problem.costgrad = @(Z) costgrad(problem.Y, Z.X, Z.Q);
    problem.ehess = @(Z,W) egrad(problem.Y,W.X,W.Q);
end