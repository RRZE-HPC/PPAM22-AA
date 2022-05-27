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
x=1;
fa = figure('Renderer', 'painters', 'Position', [10 10 1200 700])
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(8,5,i)  
    plot(Idle(:,x),'.') %plot(Idle(:,i),'.')
    set(gca, 'FontSize', 16) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)]) %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
 %   xlim([0 Iterations])
    axis([0 Iterations 0 Limits])
    x=x+PPS;
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
end
print(fa, "Idle.pdf", '-dpdf','-bestfit');
system ("pdflatex Idle");
saveas(gcf,'Idle.png')
%open Idle.pdf
savefig(fullfile('resultdir', ['Idle' '.fig']));

%% Histogram
x=1;
fb = figure('Renderer', 'painters', 'Position', [10 10 1200 700])
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
print(fb, "Dist.pdf", '-dpdf','-bestfit');
system ("pdflatex Dist");
saveas(gcf,'Dist.png')
savefig(fullfile('resultdir', ['Dist' '.fig']));
%open Dist.pdf

%% Individual processes
fe = figure(5)
subplot(2,2,1)
plot((Idle(:,20)))
title(['Rank ' num2str(19)])
xlabel('Iteration')
ylabel('MPI time [s]')
axis([0 Iterations 0 Limits])
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
subplot(2,2,2)
plot((Idle(:,21)))
title(['Rank ' num2str(20)])
xlabel('Iteration')
ylabel('MPI time [s]')
axis([0 Iterations 0 Limits])
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
subplot(2,2,3)
plot((Idle(:,30)))
title(['Rank ' num2str(19)])
xlabel('Iteration')
ylabel('MPI time [s]')
axis([0 Iterations 0 Limits])
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
subplot(2,2,4)
plot((Idle(:,31)))
title(['Rank ' num2str(20)])
xlabel('Iteration')
ylabel('MPI time [s]')
axis([0 Iterations 0 Limits])
grid on
set(gca, 'FontName', 'Times New Roman')
set(gca, 'FontSize', 16)
print(fe, "IdleRanks_20_21.pdf", '-dpdf','-bestfit');
system ("pdflatex IdleRanks_20_21");
saveas(gcf,'IdleRanks_20_21.png')
savefig(fullfile('resultdir', ['IdleRanks_20_21' '.fig']));
%open IdleRanks_20_21.pdf
