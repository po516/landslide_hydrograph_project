%This function sets the number of ghost particles based on how many
%particles we expect to be influencing the particle based on the smoothing
%length. Volumes are fixed to be the same as the real particles, and the
%spacing between the ghost particles themselves and between them and the
%boundary is scaled (all the positions are scaled linearly)

%*Maybe change code so the number of ghost particles can also change

function [pg, vg] = gmany(p, v)

global h_0 l vi a

%Set initial positions of the ghost particles
%also give the ghost particles the same volumes

pg=(-1)*[0.49:0.5:10*l];
vg=vi*ones(1,length(pg));
%Work out the height at the boundary
%pull together a matrix of real and ghost particles with their distance
%from the boundary

s_i=[pg,p(~isnan(p))];
Wi=(1/(sqrt(pi)*l))*exp(-(s_i./l).^2);
h=sum(vi*Wi);
dh=h-h_0;
%h is too low, dh is negative -> we want to increase it by moving the ghost
%particles closer together and to the boundary

%itterate to get lower dh
while abs(dh)>=1e-6
    pg=pg*a^dh;
    s_i=[abs(pg),p(~isnan(p))];
    Wi=(1/(sqrt(pi)*l))*exp(-(s_i./l).^2);
    h=sum(vi*Wi);
    dh=h-h_0;
end

end

