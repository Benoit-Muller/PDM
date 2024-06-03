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
    problem.Yto2D = @Yto2D;
    function Y2 = Yto2D(Y3)
        [dim1,dim2,dim3] = size(Y3);
        Y2 = reshape(Y3, [n, k*r]);
    end
    problem.Y2 = problem.Yto2D(problem.Y3);

    problem.chi = @(Q) 1/k * problem.Y2*Q;
    normY = norm(problem.Y2,"fro");
    problem.cost = @(Q) -1/k^2 * norm(problem.Y2*Q,"fro")^2 + 1/k*normY^2;

    problem.egrad = @(Q) -2/k^2 * problem.Y2' * (problem.Y2 * Q);

    problem.costgrad = @costgrad;
    function [c,g] = costgrad(Q)
        Y2Q = problem.Y2*Q;
        c = -1/k^2 * norm(Y2Q,"fro")^2 + 1/k*normY^2;
        g = -2/k^2 * problem.Y2' * Y2Q;
        g = problem.M.egrad2rgrad(Q,g);
    end

    problem.ehess = @(Q,V) problem.egrad(V);
    problem.Q2B = @Q2B;
    function B=Q2B(Q)
        X=problem.Y2 * Q;
        B=X*X';
    end
    problem.variance = @(B) cost_variance(problem.A,B);
    problem.egrad_variance = @(B) egrad_variance(problem.A,B);
end