function [X_org,Y_org] = original_dynamics(X,Y,K,dt,nt)

%% Inputs
% X : initial x-cordinate of point vortices
% Y : initial x-cordinate of point vortices
% K : strength of point vortices
% dt : time step
% nt : number of time steps

%% Outputs
% X_org, Y_org: trajectories of vortices


%% Run biot-savart model
n          = length(X);
z0         = [X;Y;K];              % Array of co-ordinates/strengths
X_org      = zeros(n,nt+1);           % X-cordinate frames
Y_org      = zeros(n,nt+1);           % Y-cordinate frames
X_org(:,1) = X; 
Y_org(:,1) = Y;
for m = 2:nt+1
    [~,z]         = ode45(@biot_savart,[0,dt],z0);
    x             = z(end,1:n)';
    y             = z(end,n+1:2*n)';
    X_org(:,m)    = x;
    Y_org(:,m)    = y;
    z0            = [x;y;K];
end

function [dzdt] = biot_savart(t,z)
%% Biot-savart law
n     = length(z)/3;             
x     = z(1:n);
y     = z(n+1:2*n);
kappa = z(2*n+1:end);  
u     = zeros(size(x));
v     = zeros(size(y));
for j = 1:n
    for k = 1:n
        if (j~=k)
            dx = x(j)-x(k);
            dy = y(j)-y(k);
            r2 = dx^2 + dy^2;
            u(j) = u(j) + kappa(k)*dy/r2;
            v(j) = v(j) + kappa(k)*dx/r2;
        end
    end
end
u      = -u/(2*pi);
v      =  v/(2*pi);
dkappa = zeros(size(x));
dzdt   = [u;v;dkappa];