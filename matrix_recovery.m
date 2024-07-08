function problem = matrix_recovery(S,x)
    %[n,n] = size(S);
    [d,r_x,n] = size(x) ;
    r=rank(S);
    y = pagemtimes(pagemtimes(x,"transpose",S,"none"),x);
    C=mean(pagemtimes(x,"none",x,"transpose"),3);
    problem.Csqrtinv = C^(-0.5);
    Xfactor = pagemtimes(pagemtimes(problem.Csqrtinv,x),sqrt(y));
    X= pagemtimes(Xfactor,"none", Xfactor,"transpose");
    problem.nonconvex_problem = nonconvex_problem2(X,r_x,r);
end