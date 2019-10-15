%% Sparsifying a graph (example)
clear;clc;

%% Example 
n = 50;                                % number of points
theta = linspace(0,2*pi-2*pi/(n-1),n);
xy = zeros(n,2);
x = cos(theta);
y = sin(theta);
G = zeros(n,n);
for i = 1:length(G)
    for j = 1:length(G)
        if i~=j % Avoiding self-loops
            G(i,j) = 1/sqrt((x(i)-x(j))^2+(y(i)-y(j))^2); % distance as measure
        end
    end
end

%% Original graph plot
xy(1:length(G),1) = x(1:length(G));
xy(1:length(G),2) = y(1:length(G));
figure(1), gplot(G,xy,'o-');
set(gcf, 'Color', [1 1 1]);
axis('equal');
xlim([-1.1 1.1]);
ylim([-1.1 1.1]);
axis off;

%% Sparsfied graph plot
epsilon = 1; % Approximation order (1-harsh approximation)
[G_sparse,Re] = sparsify_spectral(G,epsilon);
figure(2), gplot(G_sparse,xy,'o-');
set(gcf, 'Color', [1 1 1]);
axis('equal');
xlim([-1.1 1.1]);
ylim([-1.1 1.1]);
axis off;

