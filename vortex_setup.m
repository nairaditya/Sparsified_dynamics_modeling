function [X,Y] = vortex_setup()

%% Set up point vortices in clusters
Nclust = 5; % number of vortex clusters
lp = -5;up = 5;Nc = 19;nrange = 100;
Xp = randi([lp*nrange up*nrange],Nclust,1)/nrange;
Yp = randi([lp*nrange up*nrange],Nclust,1)/nrange;
Xc = zeros(Nc,Nclust);Yc = zeros(Nc,Nclust);
for i = 1:Nclust
    Xc(:,i)=Xp(i)+0.2*randn(Nc,1);
    Yc(:,i)=Yp(i)+0.2*randn(Nc,1);
end
Xch = reshape(Xc,Nclust*Nc,[]);
Ych = reshape(Yc,Nclust*Nc,[]);
X = zeros(Nclust*Nc+Nclust,1);Y = zeros(Nclust*Nc+Nclust,1);
i = 1;z=2;j=1;
figure(1);subplot(221);
while z < Nclust*Nc+Nclust
   X(i) = Xp(j);
   Y(i) = Yp(j);
   plot(X(i),Y(i),'ro');hold on;
   X(i+1:i+Nc)=Xch(z-j:Nc+z-j-1);
   Y(i+1:i+Nc)=Ych(z-j:Nc+z-j-1);
   plot(X(i+1:i+Nc),Y(i+1:i+Nc),'b.');hold on;
   i = i+Nc+1;
   z = i+1;
   j = j+1;
end
axis equal;