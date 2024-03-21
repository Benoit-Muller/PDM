function M = euclidean_orthogonal_factory(n,p,k)
% Manifold structure of the product of
%               The (n,p) Euclidean space 
%       k times The (p,p) orthogonal manifold
% Points are represented as a structure X with 
%       X.E the (n,p) matrix
%       X.O the (p,p,k) matrix with orthogonal slices

    factors.E = euclideanfactory(n,p);
    factors.O = stiefelfactory(p,p,k);
    
    M = productmanifold(factors);
end