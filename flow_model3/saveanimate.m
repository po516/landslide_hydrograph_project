function []=saveanimate(filename,pout,vout,uout)

global u_0 h_0

pmin=min(min(pout));
pmax=max(max(pout));
umin=min(min(uout));
umax=max(max(uout));

x=[pmin-10:0.01:pmax+10];

[e,~]=size(pout);
figure;
for i=1:e
    p=pout(i,:);
    v=vout(i,:);
    u=uout(i,:);
    %t=tout(i);
    
    [h,~]=Gauss(x,pout(i,:),vout(i,:));
    
    subplot(121)
    plot(x,h); hold on
    plot(0,h_0,'rx'); hold off %Mark h_0 at boundary
    xlim([pmin,pmax+10])
    ylim([0,3])
    xlabel('T')
    ylabel('h')
    title(['depth of flow'])
    %text(42,2.7,sprintf('%g',t))   %Saving animate doesn't work with
                                    %text...yet
    grid on
    
    subplot(122)
    plot(p,u); hold on
    plot(0,u_0,'rx'); hold off %Mark u_0 at boundary
    xlim([pmin,pmax])
    ylim([umin-1,umax+1])%%%
    xlabel('T')
    ylabel('Velocity')
    title(['velocity of fluid'])
    grid on
    
    drawnow

    frame = getframe(gcf);
    %loop = loop + 1;
    im{i} = frame2im(frame);
    
end
%filename = 'testAnimated.gif'; % Specify the output file name
for idx = 1:e
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
    end
end