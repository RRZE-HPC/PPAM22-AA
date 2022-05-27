clc;
close all;
clear all;

CompStart = dlmread('CompStart.txt');
CompStop =  dlmread('CompStop.txt');

size(CompStart)
size(CompStop)

Ranks=400; %1440 %40 %400
PPS=10; % 10 36 Processes per socket
Sockets=Ranks/PPS;
Iterations=500001; %100000
Limits=0.05; 

CompStart = reshape(CompStart,[Iterations,Ranks]);
CompStop = reshape(CompStop,[Iterations,Ranks]);

Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
%Idle = CompStop(1:end,:) - CompStart(1:end,:);

%% Overall view: absolute-mean value
fd = figure(4)
pcolor((Idle(:,:)-mean(Idle(:,:))))
shading interp
colormap(bluewhitered)
xlabel('Rank')
ylabel('Iteration')
colorbar
%caxis([-0.025 0.5])
grid on
set(gca, 'FontName', 'Times New Roman')    
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fd, "Idle-meanIdle.pdf", '-dpdf','-bestfit');
system ("pdflatex Idle-meanIdle");
saveas(gcf,'Idle-meanIdle.png')
savefig(fullfile('resultdir', ['Idle-meanIdle' '.fig']));
%open Idle-meanIdle.pdf

%% Overall view: absolute value
fz = figure(5)
pcolor(Idle(:,:)) 
shading interp
colormap(bluewhitered)
xlabel('Rank')
ylabel('Iteration')
colorbar
%caxis([-0.025 0.5])
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fz, "AbsoluteIdle.pdf", '-dpdf','-bestfit');
system ("pdflatex AbsoluteIdle");
savefig(fullfile('resultdir', ['AbsoluteIdle' '.fig']));
saveas(gcf,'AbsoluteIdle.png')
%open Idle-meanIdle.pdf


%% Histogram: Snippets view
x=1;
fc = figure('Renderer', 'painters', 'Position', [10 10 1200 700])
Idle = CompStart(2:10001,:) - CompStop(2-1:10001-1,:); 
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(8,5,i) %    subplot(8,5,i) % subplot(4,1,i)
    hist(Idle(:,x),35) %hist(Idle(:,i),35)
    set(gca, 'FontSize', 16) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)], 'FontSize', 16) %20 1*4 plot %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 Limits 0 Iterations]) 
    x=x+PPS;
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
end 
print(fc, "Dist_10K.pdf", '-dpdf','-bestfit');
system ("pdflatex Dist_10K");
saveas(gcf,'Dist_10K.png')
savefig(fullfile('resultdir', ['Dist_10K' '.fig']));

x=1;
fd = figure('Renderer', 'painters', 'Position', [10 10 1200 700])
Idle = CompStart(2:50001,:) - CompStop(2-1:50001-1,:); 
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(8,5,i) %    subplot(8,5,i) % subplot(4,1,i)
    hist(Idle(:,x),35) %hist(Idle(:,i),35)
    set(gca, 'FontSize', 16) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)], 'FontSize', 16) %20 1*4 plot %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 Limits 0 Iterations]) 
    x=x+PPS;
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
end 
print(fd, "Dist_50K.pdf", '-dpdf','-bestfit');
system ("pdflatex Dist_50K");
saveas(gcf,'Dist_50K.png')
savefig(fullfile('resultdir', ['Dist_50K' '.fig']));
