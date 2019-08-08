

function []=pull_figures(pout,vout,uout,tout,tplot)

global u_0 h_0

pmin=min(min(pout));
pmax=max(max(pout));
umin=min(min(uout));
umax=max(max(uout));

x=[pmin-10:0.01:pmax+10];

[e,~]=size(pout);
i=1:e;
tol=0.001;
m=ismembertol(tout,tplot,tol);
j=i(m)

for i=j
    p=pout(i,:);
    v=vout(i,:);
    u=uout(i,:);
    t=tout(i);
    [h,~]=Gauss(x,pout(i,:),vout(i,:));
    
    figure;
    subplot(121)
    plot(x,h); hold on
    plot(0,h_0,'rx'); hold off %Mark h_0 at boundary
    xlim([pmin,pmax+10])
    ylim([0,3])
    xlabel('T/m')
    ylabel('h/m')
    title(['depth of flow'])
    text(42,2.7,['t=',sprintf('%g',t)])  %'hello'
    grid on
    
    subplot(122)
    plot(p,u); hold on
    plot(0,u_0,'rx'); hold off %Mark u_0 at boundary
    xlim([pmin,pmax])
    ylim([umin-1,umax+1])%%%
    xlabel('T/m')
    ylabel('Velocity/ms^{-1}')
    title(['velocity of fluid'])
    grid on
        
end        