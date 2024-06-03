clear
n=4; % data dimension
k=3; % number of matrices
r=round(n/2); % size of factorization Y of data A
p=r+1; % size of factorization X of barycenter B (r<=p)
A = data(n,k,r);
prob = nonconvex_problem2(A,r,p);

checkgradient(prob);