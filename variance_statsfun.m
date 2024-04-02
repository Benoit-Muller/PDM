function stats = variance_statsfun(problem, x, stats)
    B = x.X * x.X';
    stats.variance = problem.variance(B);
    stats.egrad_norm_variance = norm(problem.egrad_variance(B),"fro");
end