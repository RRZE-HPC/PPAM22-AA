clc;
close all;
clear all;

CompStart = dlmread('CompStart.txt');
CompStop =  dlmread('CompStop.txt');

size(CompStart)
size(CompStop)

Ranks=400; %1440 %40 %400
Sockets=Ranks/10; % Ranks/36 % Ranks/10
Iterations=500001; %50000 %50001

NPC = 2 % choose the reduced number of PCA components
k = Sockets; % number of clusters need to be square of a number, e.g., 16, 25, 36 or 64

CompStart = reshape(CompStart,[Iterations,Ranks]);
CompStop = reshape(CompStop,[Iterations,Ranks]);

%% Overall view: Principal Component Analysis
Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
%Idle = CompStop(1:end,:) - CompStart(1:end,:);

ff = figure(1)
[wcoeff,score,latent,~,explained,mu] = pca(zscore(((Idle' -mean(Idle')))));
c = linspace(1,Ranks,length(score(:,1)));
scatter(score(:,1),score(:,2),[],c)
%t = score*wcoeff' %+ repmat(mu,Ranks,1)
%t = score*wcoeff'
%plot(t)
%axis equal
title('Principal component analysis')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(ff, "PCA.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA");
saveas(gcf,'PCA.png')
savefig(fullfile('resultdir', ['PCA' '.fig']));
%open PCA.pdf

f2 = figure('Renderer', 'painters', 'Position', [10 10 1200 550])
subplot(3,1,1)
plot(wcoeff(:,1))
title('1st Principal Component')
xlabel('Iteration')
ylabel('MPI time [s]')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)

subplot(3,1,2)
plot(wcoeff(:,2))
title('2nd Principal Component')
xlabel('Iteration')
ylabel('MPI time [s]')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)

subplot(3,1,3)
%plot(explained)
pareto(explained)
title('Total variance explained by each PC')
ylabel('Total variance [%]')
xlabel('Principal Component number')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)

PCA_explained = sum(explained(1:NPC))

print(f2, "PCA_advance.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA_advance");
saveas(gcf,'PCA_advance.png')
savefig(fullfile('resultdir', ['PCA_advance' '.fig']));
%open PCA_advance.pdf


f4=figure(7)
c = linspace(1,Ranks,length(score(:,1)));
scatter3(score(:,1),score(:,2),score(:,3),[],c)
%axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(f4, "PCA3_advance.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA3_advance");
saveas(gcf,'PCA3_advance.png')
savefig(fullfile('resultdir', ['PCA3_advance' '.fig']));


ff = figure(7)
subplot(2,1,1)
plot(wcoeff(:,3))
title('3rd Principal Component')
xlabel('Iteration')
ylabel('MPI-time')
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
subplot(2,1,2)
plot(wcoeff(:,4))
title('4th Principal Component')
xlabel('Iteration')
ylabel('MPI-time')
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(ff, "PCA_3rd_4th.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA_3rd_4th");
saveas(gcf,'PCA_3rd_4th.png')
savefig(fullfile('resultdir', ['PCA_3rd_4th' '.fig']));
%open PCA_3rd_4th.pdf

%% Overall view: K-mean Clustering - Sq Euclidean Distance
fh = figure(8)
%[idx,C] = kmeans(score(:,1:NPC),k,'Distance','sqeuclidean','Replicates',50,'MaxIter',1000,'Display','final'); 
[idx,C] = kmeans(score(:,1:NPC),k,'Distance','sqeuclidean') % returns the k cluster centroid locations in the matrix C.
% cityblock, cosine, sqeuclidean 
%scatter(score(:,1),score(:,2),k,idx)
gscatter(score(:,1),score(:,2),idx,'bgm')
hold on
plot(C(:,1),C(:,2),'kx','MarkerSize',25) %plot the clusters and the cluster centroids
%legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster Centroid')
title('k-mean baseline clustering - Euclidean Distance')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(fh, "Clustering1.pdf", '-dpdf','-bestfit');
system ("pdflatex Clustering1");
saveas(gcf,'Clustering1.png')
savefig(fullfile('resultdir', ['Clustering1' '.fig']));
%open Clustering1.pdf

fl = figure(12)
hist(idx,k)
%accumarray( idx, 1 ); % the number of data points of each cluster of K-means
title('Number of observables per cluster')
xlabel('Cluster ID')
ylabel('Number of samples')
grid on
set(gca, 'XTick', 0:k)
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32) 
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
counts = hist(idx,k)
[out,ii] = sort(counts,'descend') % sort it out
print(fl, "NClustering.pdf", '-dpdf','-bestfit');
system ("pdflatex NClustering");
saveas(gcf,'NClustering.png')
savefig(fullfile('resultdir', ['NClustering' '.fig']));


% calculate how good is clustering: silh2 eliminates samples that do not belong to cluster
fm = figure(13)
[silh2,h] = silhouette(score(:,1:NPC),idx,'Euclidean');
bad_samples = sum(silh2<0)
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(fm, "Silhouette.pdf", '-dpdf','-bestfit');
system ("pdflatex Silhouette");
saveas(gcf,'Silhouette.png')
savefig(fullfile('resultdir', ['Silhouette' '.fig']));

%% Snippets view: Principal Component Analysis
Idle = CompStart(499002:end,:) - CompStop(499002-1:end-1,:); 
% Idle = CompStop(499001:end,:) - CompStart(499001:end,:); 

ff = figure(1)
[wcoeff,score,latent,~,explained,mu] = pca(zscore(((Idle' -mean(Idle')))));
c = linspace(1,Ranks,length(score(:,1)));
scatter(score(:,1),score(:,2),[],c)
%t = score*wcoeff' %+ repmat(mu,Ranks,1)
%t = score*wcoeff'
%plot(t)
%axis equal
title('Principal component analysis')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(ff, "PCA-end.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA-end");
saveas(gcf,'PCA-end.png')
savefig(fullfile('resultdir', ['PCA-end' '.fig']));
%open PCA-end.pdf

f2 = figure('Renderer', 'painters', 'Position', [10 10 1200 550])
subplot(3,1,1)
plot(wcoeff(:,1))
title('1st Principal Component')
xlabel('Iteration')
ylabel('MPI time [s]')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)

subplot(3,1,2)
plot(wcoeff(:,2))
title('2nd Principal Component')
xlabel('Iteration')
ylabel('MPI time [s]')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)

subplot(3,1,3)
%plot(explained)
pareto(explained)
title('Total variance explained by each PC')
ylabel('Total variance [%]')
xlabel('Principal Component number')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)

PCA_explained = sum(explained(1:NPC))

print(f2, "PCA_advance-end.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA_advance-end");
saveas(gcf,'PCA_advance-end.png')
savefig(fullfile('resultdir', ['PCA_advance-end' '.fig']));
%open PCA_advance-end.pdf


f4=figure(7)
c = linspace(1,Ranks,length(score(:,1)));
scatter3(score(:,1),score(:,2),score(:,3),[],c)
%axis equal
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(f4, "PCA3_advance-end.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA3_advance-end");
saveas(gcf,'PCA3_advance-end.png')
savefig(fullfile('resultdir', ['PCA3_advance-end' '.fig']));


ff = figure(7)
subplot(2,1,1)
plot(wcoeff(:,3))
title('3rd Principal Component')
xlabel('Iteration')
ylabel('MPI-time')
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
subplot(2,1,2)
plot(wcoeff(:,4))
title('4th Principal Component')
xlabel('Iteration')
ylabel('MPI-time')
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(ff, "PCA_3rd_4th-end.pdf", '-dpdf','-bestfit');
system ("pdflatex PCA_3rd_4th-end");
saveas(gcf,'PCA_3rd_4th-end.png')
savefig(fullfile('resultdir', ['PCA_3rd_4th-end' '.fig']));
%open PCA_3rd_4th-end.pdf

%% Snippets view: K-mean Clustering - Sq Euclidean Distance
fh = figure(8)
%[idx,C] = kmeans(score(:,1:NPC),k,'Distance','sqeuclidean','Replicates',50,'MaxIter',1000,'Display','final'); 
[idx,C] = kmeans(score(:,1:NPC),k,'Distance','sqeuclidean') % returns the k cluster centroid locations in the matrix C.
% cityblock, cosine, sqeuclidean 
%scatter(score(:,1),score(:,2),k,idx)
gscatter(score(:,1),score(:,2),idx,'bgm')
hold on
plot(C(:,1),C(:,2),'kx','MarkerSize',25) %plot the clusters and the cluster centroids
%legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster Centroid')
title('k-mean baseline clustering - Euclidean Distance')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(fh, "Clustering1-end.pdf", '-dpdf','-bestfit');
system ("pdflatex Clustering1-end");
saveas(gcf,'Clustering1-end.png')
savefig(fullfile('resultdir', ['Clustering1-end' '.fig']));
%open Clustering1-end.pdf

fl = figure(12)
hist(idx,k)
%accumarray( idx, 1 ); % the number of data points of each cluster of K-means
title('Number of observables per cluster')
xlabel('Cluster ID')
ylabel('Number of samples')
grid on
set(gca, 'XTick', 0:k)
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32) 
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
counts = hist(idx,k)
[out,ii] = sort(counts,'descend') % sort it out
print(fl, "NClustering-end.pdf", '-dpdf','-bestfit');
system ("pdflatex NClustering-end");
saveas(gcf,'NClustering-end.png')
savefig(fullfile('resultdir', ['NClustering-end' '.fig']));


% calculate how good is clustering: silh2 eliminates samples that do not belong to cluster
fm = figure(13)
[silh2,h] = silhouette(score(:,1:NPC),idx,'Euclidean');
bad_samples = sum(silh2<0)
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(fm, "Silhouette-end.pdf", '-dpdf','-bestfit');
system ("pdflatex Silhouette-end");
saveas(gcf,'Silhouette-end.png')
savefig(fullfile('resultdir', ['Silhouette-end' '.fig']));
