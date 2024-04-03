function M = euclidean_orthogonal_factory(n,r,p,k)
% Manifold structure of the product of
%               The (n,p) Euclidean space 
%       k times The (r,p) stiefel manifold
% Points are represented as a structure X with 
%       X.X the (n,p) matrix
%       X.Qt the (r,p,k) matrix with orthogonal slices

    product.X = euclideanfactory(n,p);
    product.Qt = stiefelfactory(p,r,k);
    
    M = productmanifold(product);
end