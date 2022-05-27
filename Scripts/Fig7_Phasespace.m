clc;
close all;
clear all;

CompStart = dlmread('CompStart.txt');
CompStop =  dlmread('CompStop.txt');

size(CompStart)
size(CompStop)

Ranks=1440; %1440 %40 %400
PPS=36; % 10, 36
Sockets=Ranks/PPS; 
Iterations=500000; %100000
Limits=1; 

CompStart = reshape(CompStart,[Iterations,Ranks]);
CompStop = reshape(CompStop,[Iterations,Ranks]);

%% Snippets view: temporal evolution for selected regions
fc = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(2:101,:) - CompStop(2-1:101-1,:);
%Idle = CompStop(2:101,:) - CompStart(2:101,:);
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fc, "PhaseSpace_start.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_start");
saveas(gcf,'PhaseSpace_start.png')
savefig(fullfile('resultdir', ['PhaseSpace_start' '.fig']));


fd = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(502:601,:) - CompStop(502-1:601-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fd, "PhaseSpace_start2.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_start2");
saveas(gcf,'PhaseSpace_start2.png')
savefig(fullfile('resultdir', ['PhaseSpace_start2' '.fig']));
%open PhaseSpace.pdf

fe = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(902:1001,:) - CompStop(902-1:1001-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fe, "PhaseSpace_start3.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_start3");
saveas(gcf,'PhaseSpace_start3.png')
savefig(fullfile('resultdir', ['PhaseSpace_start3' '.fig']));
%open PhaseSpace.pdf

ff = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(1902:2001,:) - CompStop(1902-1:2001-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(ff, "PhaseSpace_start4.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_start4");
saveas(gcf,'PhaseSpace_start4.png')
savefig(fullfile('resultdir', ['PhaseSpace_start4' '.fig']));
%open PhaseSpace.pdf

fg = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(2902:3001,:) - CompStop(2902-1:3001-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fg, "PhaseSpace_mid1.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_mid1");
saveas(gcf,'PhaseSpace_mid1.png')
savefig(fullfile('resultdir', ['PhaseSpace_mid1' '.fig']));
%open PhaseSpace.pdf

fh = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(9902:10001,:) - CompStop(9902-1:10001-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fh, "PhaseSpace_mid2.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_mid2");
saveas(gcf,'PhaseSpace_mid2.png')
savefig(fullfile('resultdir', ['PhaseSpace_mid2' '.fig']));
%open PhaseSpace.pdf

fi = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(49902:50001,:) - CompStop(49902-1:50001-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fi, "PhaseSpace_mid3.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_mid3");
saveas(gcf,'PhaseSpace_mid3.png')
savefig(fullfile('resultdir', ['PhaseSpace_mid3' '.fig']));
%open PhaseSpace.pdf

fj = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(499902:500001,:) - CompStop(499902-1:500001-1,:); 
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fj, "PhaseSpace_end1.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_end1");
saveas(gcf,'PhaseSpace_end1.png')
savefig(fullfile('resultdir', ['PhaseSpace_end1' '.fig']));
%open PhaseSpace.pdf

fk = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(499001:500000,:) - CompStop(499001-1:500000-1,:);
Idle = CompStop(99000:99999,:) - CompStart(99000:99999,:);
scatter(Idle(1:end-1,:),Idle(2:end,:))
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fk, "PhaseSpace_end2.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_end2");
saveas(gcf,'PhaseSpace_end2.png')
savefig(fullfile('resultdir', ['PhaseSpace_end2' '.fig']));
