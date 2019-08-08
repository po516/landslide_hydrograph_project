%function for plotting the flow and the velocity of the flow at different
%points

function [] = plotflow(pall1,p,vall1,u,t)

global l
%work out heigts of the flow along 
pmin=min(pall1);
pmax=max(pall1);

x=[pmin-10:0.01:pmax+10];

s_ij=repmat(pall1',[1,length(x)])-repmat(x,[length(pall1),1]); %Matrix of distances between particles
Vj=repmat(vall1',[1,length(x)]);
Wij=(1/(sqrt(pi)*l))*exp(-(s_ij./l).^2);
hi1=sum(Vj.*Wij);

figure;
subplot(121)
plot(x,hi1); hold on
plot(0,2,'rx')
xlabel('T')
ylabel('h')
title('depth of flow')
text(42,2.7,['t=',sprintf('%g',t)])
subplot(122)
plot(p(~isnan(p)),u) %only the real particles have velocities
xlabel('T')
ylabel('Velocity')
title('velocity of fluid')