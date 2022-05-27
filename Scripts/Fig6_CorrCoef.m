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

%% Overall view
fc = figure(3)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fc, "corrcoef.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef");
saveas(gcf,'corrcoef.png')
savefig(fullfile('resultdir', ['corrcoef' '.fig']));
%open corrcoef.pdf

%% Snippets view
Idle = CompStart(2:101,:) - CompStop(2-1:101-1,:); 
fd = figure(4)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fd, "corrcoef_start.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_start");
saveas(gcf,'corrcoef_start.png')
savefig(fullfile('resultdir', ['corrcoef_start' '.fig']));
%open corrcoef_start.pdf

Idle = CompStart(502:601,:) - CompStop(502-1:601-1,:); 
fe = figure(5)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')    
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fe, "corrcoef_start2.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_start2");
saveas(gcf,'corrcoef_start2.png')
savefig(fullfile('resultdir', ['corrcoef_start2' '.fig']));
%open corrcoef_start2.pdf

Idle = CompStart(902:1001,:) - CompStop(902-1:1001-1,:); 
ff = figure(6)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(ff, "corrcoef_start3.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_start3");
saveas(gcf,'corrcoef_start3.png')
savefig(fullfile('resultdir', ['corrcoef_start3' '.fig']));
%open corrcoef_start3.pdf

Idle = CompStart(1902:2001,:) - CompStop(1902-1:2001-1,:); 
fg = figure(7)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fg, "corrcoef_start4.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_start4");
saveas(gcf,'corrcoef_start4.png')
savefig(fullfile('resultdir', ['corrcoef_start4' '.fig']));
%open corrcoef_start4.pdf

Idle = CompStart(2902:3001,:) - CompStop(2902-1:3001-1,:); 
fh = figure(8)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fh, "corrcoef_mid1.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_mid1");
saveas(gcf,'corrcoef_mid1.png')
savefig(fullfile('resultdir', ['corrcoef_mid1' '.fig']));
%open corrcoef_mid1.pdf

Idle = CompStart(9902:10001,:) - CompStop(9902-1:10001-1,:); 
fi = figure(9)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')    
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fi, "corrcoef_mid2.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_mid2");
saveas(gcf,'corrcoef_mid2.png')
savefig(fullfile('resultdir', ['corrcoef_mid2' '.fig']));
%open corrcoef_mid2.pdf

Idle = CompStart(49902:50001,:) - CompStop(49902-1:50001-1,:); 
fj = figure(10)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fj, "corrcoef_mid3.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_mid3");
saveas(gcf,'corrcoef_mid3.png')
savefig(fullfile('resultdir', ['corrcoef_mid3' '.fig']));
%open corrcoef_mid3.pdf

Idle = CompStart(499902:end,:) - CompStop(499902-1:end-1,:); 
fk = figure(11)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fk, "corrcoef_end1.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_end1");
saveas(gcf,'corrcoef_end1.png')
savefig(fullfile('resultdir', ['corrcoef_end1' '.fig']));
%open corrcoef_end1.pdf

Idle = CompStart(499002:end,:) - CompStop(499002-1:end-1,:); 
fl = figure(12)
R = corrcoef(Idle(:,:))
imagesc(R)
colormap('turbo')
colorbar
xlabel('Rank')
ylabel('Rank')
caxis([0 1.0])
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fl, "corrcoef_end2.pdf", '-dpdf','-bestfit');
system ("pdflatex corrcoef_end2");
saveas(gcf,'corrcoef_end2.png')
savefig(fullfile('resultdir', ['corrcoef_end2' '.fig']));
%open corrcoef_end2.pdf