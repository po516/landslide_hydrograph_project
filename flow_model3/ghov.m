function [v]=ghov(p,v)

global h_0

ig=find(p<0); %indices of the ghost particles
[h_at0,~]=Gauss(0,p,v);

herr=h_0-h_at0;

while herr>=1e-6
    v(ig)=v(ig)*exp(herr); 
    [h_at0,~]=Gauss(0,p,v);
    herr=h_0-h_at0;
end
