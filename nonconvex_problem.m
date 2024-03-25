function problem = nonconvex_problem(A,p)
    [n,n,k] = size(A);
    problem.n=n;
    problem.k=k;
    problem.p=p;
    problem.A = A;
    problem.Y = A;
    for i=1:k
        problem.Y(:,:,i) = sqrtm(A(:,:,i));
    end
    problem.cost = @(X) cost(problem.Y, X.E, X.O);
    problem.M = euclidean_orthogonal_factory(n,p,k);
    problem.egrad = @(X) egrad(problem.Y,X.E,X.O);
end