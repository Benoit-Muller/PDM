function problem = convex_problem(A)
    [n,~,k] = size(A);
    problem.n=n;
    problem.k=k;
    problem.A = A;
    problem.cost = @(B) cost_variance(A,B);
    problem.M = sympositivedefinitefactory(n);
    problem.egrad = @(B) egrad_variance(A,B);
end