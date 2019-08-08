%function for plotting the flow and the velocity of the flow at different
%points

function [] = plotflow3(p,v,u,t);

global u_0
%work out heigts of the flow along 
pmin=min(p);
pmax=max(p);

% u2=NaN(n);
% u2(1:length(u))=u;

x=[pmin-10:0.01:pmax+10];

[h,~]=Gauss(x,p,v);

figure;
subplot(121)
plot(x,h); hold on
plot(0,2,'rx')
xlabel('T')
ylabel('h')
title('depth of flow')
text(42,2.7,['t=',sprintf('%g',t)])
subplot(122)
plot(p,u); hold on
plot(0,u_0,'rx')
xlabel('T')
ylabel('Velocity')
title('velocity of fluid')