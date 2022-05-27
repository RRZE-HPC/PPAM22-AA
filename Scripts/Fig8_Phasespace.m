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

Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
%Idle = CompStop(1:end,:) - CompStart(1:end,:);

%% Overall view: overall temporal evolution for individual first MPI processes on each socket
f = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
%Idle = CompStop(1:end,:) - CompStart(1:end,:);
%c = linspace(1,Iterations-1,Iterations-2);
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(8,5,i)  % subplot(80,18,i) %subplot(8,5,i)
    scatter(Idle(1:end-1,i),Idle(2:end,i))%,[],c)
    set(gca, 'FontSize', 16) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)]) %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 Limits 0 Limits])
    grid on
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
end 
print(f, "PhaseSpace_All.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_all");
saveas(gcf,'PhaseSpace_all.png')
savefig(fullfile('resultdir', ['PhaseSpace_all' '.fig']));
close(f)


%% Overall view: overall temporal evolution for all MPI processes
fb = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
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
print(fb, "PhaseSpace_allrank.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace_allrank");
saveas(gcf,'PhaseSpace_allrank.png')
savefig(fullfile('resultdir', ['PhaseSpace_allrank' '.fig']));

%% Overall view: overall temporal evolution for rank 32 only
fa = figure('Renderer', 'painters', 'Position', [10 10 700 550])
Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
Idle = CompStop(2:end,:) - CompStart(2:end,:);
c = linspace(1,Iterations-1,Iterations-2);
scatter(Idle(1:end-1,32),Idle(2:end,32),[],c)
axis([0 Limits 0 Limits])  %axis([0 0.2 0 0.2]) 
title('Clustering in phase space')
xlabel('MPI time [s] at nth iteration')
ylabel('MPI time [s] at (n+1)th iteration')
colorbar
grid on
set(gca, 'FontName', 'Times New Roman')     
set(gca,'FontWeight','bold')
set(gca, 'FontSize', 32)
print(fa, "PhaseSpace.pdf", '-dpdf','-bestfit');
system ("pdflatex PhaseSpace");
saveas(gcf,'PhaseSpace.png')
savefig(fullfile('resultdir', ['PhaseSpace' '.fig']));
open PhaseSpace.pdf