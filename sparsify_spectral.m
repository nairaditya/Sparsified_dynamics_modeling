%% Sparsify - Aditya Nair, Kunihiko Taira
%% Input : A -Adjacency matrix , epsilon - approximation order
%% Output: A_sparse - Sparsified adjacency matrix, Re - effective resistance
%% Initializing Parameters
function [A_sparse,Re] = sparsify_spectral(A,epsilon)
%% Initializing Parameters

N        = length(A);                     % Number of vortices
A        = (A + A')/2;                    % make adjacency matrix symmetric 
L        = diag(sum(A))-A;                % Laplacian Matrix
L_plus   = pinv(L);                       % Moore-Penrose Pseudoinverse
edges1   = find(triu(A>0));               % indices of all edges
L = [];                                   % delete variable (save memory)

%% Calculate Effective resistance

[pp,qq]= ind2sub([N,N],edges1);           % index numbers of edge
Re     = zeros(length(edges1),1);         % effective resistance
we     = zeros(length(edges1),1);         % weights of original graph

for i=1:length(pp)
    we(i) = A(pp(i),qq(i));
    Re(i) = (L_plus(pp(i),pp(i)) - L_plus(qq(i),pp(i)))-...
            (L_plus(pp(i),qq(i)) - L_plus(qq(i),qq(i)));
end

L_plus = [];                      % delete variable (save memory)
pe = we.*Re;                      % probability 
pe = pe/sum(pe);                  % normalizing probabilities 
c  = cumsum(pe);                  % cumulative
edges = [0;c];                    % creating probability bins
c = [];                           % delete variables (save memory)

%% Random sampling

q    = ceil(8*N*log2(N)/(epsilon^2));   % Number of samples
el_G = zeros(length(edges1),1);         % Sparsified edge list

r = rand(q,1);                 % Choose random values between 0 and 1
[num,~] = histc(r,edges);      % Get bin index of the random number

%% Spectral sparsification procedure (vectorized)
el_G(1:length(edges)-1,1) = el_G(1:length(edges)-1,1) ...
+num(1:length(edges)-1).*(we(1:length(edges)-1)./(pe(1:length(edges)-1)*q));

%% Sparsified Adjacency matrix

A_sparse = edgeL2adj(el_G,pp,qq,N);
A_sparse = triu(A_sparse,-1)'+A_sparse;

%% Edge list to adjacency matrix

function adj=edgeL2adj(el,pp,qq,n)
adj = zeros(n,n);
% across all edges
for i=1:size(el,1); 
    adj(pp(i),qq(i))=el(i,1);
end
