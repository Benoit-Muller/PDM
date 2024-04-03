n=5; % data dimension
k=5; % number of matrices
r=round(n/2); % size of factorization Y of data A
p=r+1; % size of factorization X of barycenter B
A = data(n,k,r);
% Amean = mean(A,3);
% x0.X = sqrt(Amean);
prob = nonconvex_problem(A,r,p);
niter=5;
X = zeros(n,p,niter);
options.verbosity=0;
for j=1:niter
    j
    x = trustregions(prob,[],options);
    X(:,:,j) = x.X;
end
Bs = pagemtimes(X, multitransp(X));
Bmean = sum(Bs,3)/niter
Bstd = norm(Bmean-Bs,"fro")/(niter-1);
Bstd_relative = Bstd/norm(Bmean,"fro")