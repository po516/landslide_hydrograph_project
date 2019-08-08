clear all
close all
% I want to see whether the gradient at the position of the particle is the 
% same for both solutions.

global h_0 n B Q dtp l vi a
%Set variables
h_0=2; %height at the boundary
n=200; %number of particles
B=4; %Smoothing constant
Q=10; %Instantaneous discharge
dtp=0.1; %Time between particles being added
a=exp(1); %for iteration in seting the ghost particles
l=B/sqrt(h_0/(Q*dtp)); %smoothing length for SPH calculation

nNaN=NaN(1,n);
u=[];
p=nNaN;
d=0.01;
vi=Q*dtp;
v=ones(1,n)*vi;

g=9.81;
alpha=pi/6; %slope angle
g_N=g*cos(alpha); %gravity in the N (normal) direction
k_N=1; %Rankine Earth Pressure
%A should be adjusted to make the solution nice. It sets how strongly the
%acceleration depends on the depth of the flow.
A=1;

%timestep for iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt=0.05;
t=0; %at start
tpa=[0:dtp:dtp*n-dtp];
%initial u for 1 particle
u_0=5;

%for storing positions and velocities at each timestep (optional)
n2NaN=NaN(1,n+100);
pall=n2NaN;
vall=n2NaN;
paout=[];
vaout=[];
uout=[];
tout=[];

while t<=25
%Add particle if t is at a certain point
    try
    if t>=tpa(1)
        % in p: first NaN replaced by d
        p(find(isnan(p), 1))=d;
        % set velocity at this particle
        u=[u,u_0];
        % remove first item in tpa
        tpa=tpa(2:end);
    end
%................................................................change ghost settings here
%................................................................
%................................................................
%Find heights and gradients at particles 
    [pg1, vg1] = gmany(p,v); %find ghost particles
    pall1=[pg1,p(~isnan(p))];
    vall1=[vg1,v(~isnan(p))];

    s_ij=repmat(pall1',[1,length(p(~isnan(p)))])-repmat(p(~isnan(p)),[length(pall1),1]); %Matrix of distances between particles
    Vj=repmat(vall1',[1,length(p(~isnan(p)))]);
    Wij=(1/(sqrt(pi)*l))*exp(-(s_ij./l).^2);
    hi1=sum(Vj.*Wij);
    dWij_dT=(2*s_ij./(sqrt(pi)*l^3)).*exp(-(s_ij./l).^2);
    dh_dt_1=sum(Vj.*dWij_dT);

%Find new positions    
    du_dt=-g_N*k_N*dh_dt_1+A*(hi1-h_0);  %acceleration
    u=dt*du_dt+u;                       %velocity
    p(~isnan(p))=p(~isnan(p))+u*dt;
    t=t+dt; 
    
    catch %if we've added all the particles, we don't want any more ghost particles
    pall1=[p(~isnan(p))];
    vall1=[v(~isnan(p))];

    s_ij=repmat(pall1',[1,length(p(~isnan(p)))])-repmat(p(~isnan(p)),[length(pall1),1]); %Matrix of distances between particles
    Vj=repmat(vall1',[1,length(p(~isnan(p)))]);
    Wij=(1/(sqrt(pi)*l))*exp(-(s_ij./l).^2);
    hi1=sum(Vj.*Wij);
    dWij_dT=(2*s_ij./(sqrt(pi)*l^3)).*exp(-(s_ij./l).^2);
    dh_dt_1=sum(Vj.*dWij_dT);

%Find new positions    
    du_dt=-g_N*k_N*dh_dt_1+A*(hi1-h_0);  %acceleration
    u=dt*du_dt+u;                       %velocity
    p(~isnan(p))=p(~isnan(p))+u*dt;
    t=t+dt; 
    end
%(optional) Store positions for animation of flow
pall(~isnan(pall1))=pall1;
vall(~isnan(vall1))=vall1;
    paout=[paout; pall];
    vaout=[vaout; vall];
unan=nNaN;
unan(~isnan(p))=u;
    uout=[uout; unan];  
    tout=[tout; t];
end
%plotflow(pall1,p,vall1,u,t)

%(optional) show animation
%plot_animate(paout,vaout,uout,tout)
%tplot=[0.5,4.5,8,10];
%pull2(paout,vaout,uout,tout,tplot)

saveanimate2('gmany2.1.gif',paout,vaout,uout)