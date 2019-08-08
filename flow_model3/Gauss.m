function [h,dh_dT]=Gauss(pr,p,v)

global l

p=p(~isnan(p));
v=v(~isnan(v));

s_ij=repmat(p',[1,length(pr)])-repmat(pr,[length(p),1]); %Matrix of distances between particles
Vj=repmat(v',[1,length(pr)]);

Wij=(1/(sqrt(pi)*l))*exp(-(s_ij./l).^2);
h=sum(Vj.*Wij);
dWij_dT=(2*s_ij./(sqrt(pi)*l^3)).*exp(-(s_ij./l).^2);
dh_dT=sum(Vj.*dWij_dT);