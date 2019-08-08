%function for plotting the flow and the velocity of the flow at different
%points

function [] = plot_animate(paout,vaout,uout,tout)


global l
%work out heigts of the flow along 
pmin=min(min(paout));
pmax=max(max(paout));

x=[pmin-10:0.01:pmax+10];

[e,~]=size(paout);
figure;

for i=1:e

    pall1=paout(i,:);
    pall1=pall1(~isnan(pall1));
    p=pall1(pall1>=0); %These are the real particles
    vall1=vaout(i,:);
    vall1=vall1(~isnan(vall1));
    u=uout(i,:);
    u=u(~isnan(u));
    t=tout(i);
    
s_ij=repmat(pall1',[1,length(x)])-repmat(x,[length(pall1),1]); %Matrix of distances between particles
Vj=repmat(vall1',[1,length(x)]);
Wij=(1/(sqrt(pi)*l))*exp(-(s_ij./l).^2);
hi1=sum(Vj.*Wij);

subplot(121)
plot(x,hi1); hold on
plot(0,2,'rx'); hold off
xlim([pmin,pmax+10])
ylim([0,3]) %Change this to be max and min velocities rather than set numbers
xlabel('T')
ylabel('h')
title(['depth of flow'])
text(42,2.7,['t=',sprintf('%g',t)])
grid on
subplot(122)
try
plot(p,u) 
catch
    size(p)
    size(u)
end
xlim([pmin,pmax])
ylim([3,10])
xlabel('T')
ylabel('Velocity')
title(['velocity of fluid'])
pause(0.05)
drawnow

end      
