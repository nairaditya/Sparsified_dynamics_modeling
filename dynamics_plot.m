function dynamics_plot(X,Y,X_org,Y_org,X_sparse,Y_sparse,nt)

cmap = jet(5);
Xm = mean(X);Ym = mean(Y);
r_macro = mean(sqrt((X-Xm).^2+(Y-Ym).^2));
X_org = [X X_org(:,1:nt)];X_org = (X_org-Xm)/r_macro;
Y_org = [Y Y_org(:,1:nt)];Y_org = (Y_org-Ym)/r_macro;
X_sparse = [X X_sparse(:,1:nt)];X_sparse = (X_sparse - Xm)/r_macro;
Y_sparse = [Y Y_sparse(:,1:nt)];Y_sparse = (Y_sparse - Ym)/r_macro;

x11 = mean(X_sparse(1:20,:),1);y11 = mean(Y_sparse(1:20,:),1);
x11o = mean(X_org(1:20,:),1);  y11o = mean(Y_org(1:20,:),1);
x22 = mean(X_sparse(21:40,:),1);y22 = mean(Y_sparse(21:40,:),1);
x22o = mean(X_org(21:40,:),1);  y22o = mean(Y_org(21:40,:),1);
x33 = mean(X_sparse(41:60,:),1);y33 = mean(Y_sparse(41:60,:),1);
x33o = mean(X_org(41:60,:),1);  y33o = mean(Y_org(41:60,:),1);
x44 = mean(X_sparse(61:80,:),1);y44 = mean(Y_sparse(61:80,:),1);
x44o = mean(X_org(61:80,:),1);  y44o = mean(Y_org(61:80,:),1);
x55 = mean(X_sparse(81:100,:),1);y55 = mean(Y_sparse(81:100,:),1);
x55o = mean(X_org(81:100,:),1);  y55o = mean(Y_org(81:100,:),1);


figure;
subplot(221);hold on;
plot(x11,y11,'-',x11o,y11o,'--','Color',[cmap(1,:)]);
plot(x22,y22,'-',x22o,y22o,'--','Color',[cmap(2,:)]);
plot(x33,y33,'-',x33o,y33o,'--','Color',[cmap(3,:)]);
plot(x44,y44,'-',x44o,y44o,'--','Color',[cmap(4,:)]);
plot(x55,y55,'-',x55o,y55o,'--','Color',[cmap(5,:)]);
plot(x11(1),y11(1),'o','MarkerFaceColor',[cmap(1,:)],...
    'MarkerEdgeColor',[cmap(1,:)]);
plot(x22(1),y22(1),'o','MarkerFaceColor',[cmap(2,:)],...
    'MarkerEdgeColor',[cmap(2,:)]);
plot(x33(1),y33(1),'o','MarkerFaceColor',[cmap(3,:)],...
    'MarkerEdgeColor',[cmap(3,:)]);
plot(x44(1),y44(1),'o','MarkerFaceColor',[cmap(4,:)],...
    'MarkerEdgeColor',[cmap(4,:)]);
plot(x55(1),y55(1),'o','MarkerFaceColor',[cmap(5,:)],...
    'MarkerEdgeColor',[cmap(5,:)]);
hold off;axis square;
xlim([-2 2]);ylim([-2 2]);box on;
