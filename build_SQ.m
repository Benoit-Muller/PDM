function [S,Q2,Q3] = build_SQ(r,p,k,s)
% build a S=Q*Q' such that Q=[Q1',...,Qk']' is of size [r*k,p] 
% with Q_j * Q_j' = I and rank(S)=s.
    assert(r<=p,"r<=p must be satisfied.");
    assert(r<=s && s<=p && s<=r*k,"r<=s<=min([p,r*k]) must be satisfied.");
    
    Ip=eye(p);
    Q2=repmat(Ip(1:r,:),k,1);
    Q2(r:s,:)=Ip(r:s,:);
    S=Q2*Q2';
    Q3=multitransp(reshape(Q2',[p,r,k]));
    assert(rank(S)==s,"Assertion error, rank(S)=s not satisfied.")
end