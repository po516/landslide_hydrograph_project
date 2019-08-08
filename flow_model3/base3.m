clear all
close all

global h_0 l u_0 vi
%Set variables
h_0=2;
n=150;
B=4;
Q=10;
dtp=0.1;
dt=0.05;
l=B/sqrt(h_0/(Q*dtp));
vi=1;

g=9.81;
alpha=pi/6;
g_N=g*cos(alpha); %gravity in the N (normal) direction
k_N=1; %Rankine Earth Pressure
%A should be adjusted to make the solution nice. It sets how strongly the
%acceleration depends on the depth of the flow.
A=1;

%start of transition zone is -10*l and through this zone, particles move at
%a fixed rate. As soon as they leave this zone, their velocity is
%calculated based on the depth and slope of the top surface of the flow.
d=-10*l;

%Boundary condition will be fit by adjusting the volumes of the ghost
%particles. Will adjusting the volumes further from the boundary more
%produce a smoother solution? Or just make it take longer to fit?

nNaN=NaN(1,n);
u=nNaN; %set initial vectors for velocity 
p=nNaN; %and particle position
v=nNaN; %and particle volume

tpa=[0:dtp:dtp*n-dtp]; %Times at which particles are added
%initial u for 1 particle
u_0=5;

%Initialise arrays for storing values to be shown in animation
pout=[];
vout=[];
uout=[];
tout=[];

t=0;
while t<=25
    %add particles
    try
    if t>=tpa(1)
        % in p: first NaN replaced by d
        p(find(isnan(p), 1))=d;
        %set volume at vi as a default
        v(find(isnan(v), 1))=vi;
        % set velocity at this particle
        u(find(isnan(u), 1))=u_0;
        % remove first item in tpa
        tpa=tpa(2:end);
    end
    end
    
    pr=p(p>=0); %Finds the positions and the indices of the real particles
    ir=find(p>=0); 
    pg=p(p<0);
    if (length(pr)>=1)
    %Work out volumes of ghost particles so the height fits at the boundary
    %as well as returning the indexes of the ghost particles
    v=vi*(p./p); %reset volumes - some ghost particles may now be real
    if (length(pg)>=1) %if there eare any ghost particles,
    [v]=ghov(p,v); %find their volumes
    end
    
    %calculate heights and slopes at real particle positions
        [h,dh_dT]=Gauss(pr,p,v); %this is a function that finds heights and 
                                 %gradients at pr based on particles p with
                                 %volumes v
    
    %update velocities of real particles
    du_dt=-g_N*k_N*dh_dT+A*(h-h_0);  %acceleration. This is where we use A
    u(ir)=dt*du_dt+u(ir);                       %velocity
    end
    
    %Update positions and time 
    p(~isnan(p))=p(~isnan(p))+u(~isnan(u))*dt;
    t=t+dt;     
    
    %Add particle position, volume and velocity as well as current time to
    %arrays to store for animation
    pout=[pout; p];
    vout=[vout; v];
    uout=[uout; u];
    tout=[tout; t];
    
end
%% plotting section

%plotflow3(p,v,u,t)
%plotanimate3(pout,vout,uout,tout)

%tplot=[1,4.7,5.9,7,9,12,14.9];
%pull_figures(pout,vout,uout,tout,tplot);

filename='buffer1.1.gif';
saveanimate(filename,pout,vout,uout)