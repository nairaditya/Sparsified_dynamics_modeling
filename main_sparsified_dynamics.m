%% A. G. Nair & K. Taira, ?Network-theoretic approach to sparsified 
%% discrete vortex dynamics,? J. Fluid Mech. 768, 549-571, 2015
%% Vortical graph sparsification
                  

%% Initial Setup 
[X,Y]  = vortex_setup(); % setup vortex clusters (positions)
K      = 0.1 + 0.01*randn(size(X)); % setup vortex strengths
dt     = 0.01;                 % time step 
nt     = 4200;                 % number of time stamps

%% Run original dynamics

[X_org,Y_org] = original_dynamics(X,Y,K,dt,nt);

%% Run sparficied dynamics

epsilon = 1;
[X_sparse,Y_sparse, A_sparse] = sparsified_dynamics(X,Y,K,epsilon,dt,nt);

%% Plotting

dynamics_plot(X,Y,X_org,Y_org,X_sparse,Y_sparse,nt);