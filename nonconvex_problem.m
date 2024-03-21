function problem = nonconvex_problem(A,p)
    [n,n,k] = size(A);
    problem.n=n;
    problem.k=k;
    problem.p=p;
    problem.A = A;
    problem.Y = sqrtm(A); % A=Y*Y'
    problem.cost = @(X) cost(Y, X.E, X.O);
    problem.M = euclidean_orthogonal_factory(n,p,k);
    problem.egrad = egrad;
end