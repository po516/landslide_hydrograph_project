%This function sets ONE ghost particle at a distance of ~2m~ upslope of the
%boundary and varies its volume until the height at the boundary matches
%the intended value

function [pg, vg] = gone(p, v)

global h_0 l vi a

%Set position of 1 ghost particle
pg=-2;

%Set initial volume of the ghost particle
vg=vi;

%calculate the height at the boundary
s_i=[abs(pg),p(~isnan(p))];
Wi=(1/(sqrt(pi)*l))*exp(-(s_i./l).^2);
Vi=[vg,v(~isnan(p))];
h=sum(Vi.*Wi);
dh=h-h_0;

%iterate to find better h
while abs(dh)>=1e-6
    vg=vg*a^(-dh);
    s_i=[pg,p(~isnan(p))];
    Wi=(1/(sqrt(pi)*l))*exp(-(s_i./l).^2);
    Vi=[vg,v(~isnan(p))];
    h=sum(Vi.*Wi);
    dh=h-h_0;
end
