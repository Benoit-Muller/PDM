n=3; % data dimension
k=5; % number of matrices
p=n; % size of factorization X of barycenter B
r=n; % size of factorization Y of data A (r>=p)
A = data(n,k,r);
prob = nonconvex_problem(A,r,p);
checkgradient(prob);