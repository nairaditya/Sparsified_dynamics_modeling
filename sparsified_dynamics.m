function [X_sparse,Y_sparse,A_sparse] = sparsified_dynamics(X,Y,K,epsilon,dt,nt)

%% Inputs
% X : initial x-cordinate of point vortices
% Y : initial x-cordinate of point vortices
% K : strength of point vortices
% epsilon: sparsification order
% dt : time step
% nt : number of time steps

%% Outputs
% X_sparse, Y_sparse: sparse trajectories of vortices
% A_sparse : sparse adjacency matrix

%% Setup sparsification

global rho;
n             = length(X);
z0            = [X;Y;K];              % Array of co-ordinates/strengths
A             = adj_matrix(n,K,X,Y);% Set adjacency matrix
[A_sparse,~]  = sparsify_spectral(A,epsilon); % spectral sparsification
rho           = A_sparse./A;                  % sparsification ratio

%% Run sparsified-dynamics model

X_sparse      = zeros(n,nt+1);           % X-cordinate frames
Y_sparse      = zeros(n,nt+1);           % Y-cordinate frames
X_sparse(:,1) = X; 
Y_sparse(:,1) = Y;
for m = 2:nt+1
    [~,z]         = ode45(@biot_savart,[0,dt],z0);
    x             = z(end,1:n)';
    y             = z(end,n+1:2*n)';
    X_sparse(:,m) = x;
    Y_sparse(:,m) = y;
    z0 = [x;y;K];
end

function [dzdt] = biot_savart(t,z)
%% (Sparsified) Biot-savart law
global rho;
n     = length(z)/3;             
x     = z(1:n);
y     = z(n+1:2*n);
kappa = z(2*n+1:end);  
u     = zeros(size(x));
v     = zeros(size(y));
for j = 1:n
    for k = 1:n
        if ((j~=k) && rho(j,k)~=0)
            dx = x(j)-x(k);
            dy = y(j)-y(k);
            r2 = dx^2 + dy^2;
            u(j) = u(j) + rho(j,k)*kappa(k)*dy/r2;
            v(j) = v(j) + rho(j,k)*kappa(k)*dx/r2;
        end
    end
end
u      = -u/(2*pi);
v      =  v/(2*pi);
dkappa = zeros(size(x));
dzdt   = [u;v;dkappa];


function A = adj_matrix(N,K,x,y)
%% Adjacency Matrix - Aditya Nair, Kunihiko Taira
%Input: %N :Number of point vortices
%K      :Strength of vortices
%x,y    : Cordinates of vortices
%Output :%A :Adjacency Matrix
A = zeros(N,N);
for i = 1:N
    for j = 1:N
        if i~=j
            r  = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);  
            A(i,j) = 0.5*(abs(K(i))+abs(K(j)))*(1/r);
        else
            A(i,j) = 0;
        end
    end
end