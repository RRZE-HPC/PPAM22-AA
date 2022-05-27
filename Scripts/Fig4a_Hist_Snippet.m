clc;
close all;
clear all;

CompStart = dlmread('CompStart.txt');
CompStop =  dlmread('CompStop.txt');

size(CompStart)
size(CompStop)

Ranks=40; %1440 %40 %400
PPS=10; %36
Sockets=Ranks/PPS;
Iterations=500001; %100000 
Limits=0.05; 

CompStart = reshape(CompStart,[Iterations,Ranks]);
CompStop = reshape(CompStop,[Iterations,Ranks]);

%Idle = CompStart(2:end,:) - CompStop(1:end-1,:);
%Idle = CompStop(1:end,:) - CompStart(1:end,:);

x=1;
fb = figure(1)%'Renderer', 'painters', 'Position', [10 10 1200 700])
for i=2:2000:10000 %1:Sockets % 1:Ranks
    Idle = CompStart(i:i+1000,:) - CompStop(i-1:i+1000-1,:);
    subplot(2,5,x)
    x=x+1;
    hist(Idle(:,20),35)
    set(gca, 'FontSize', 32) % 32 1*4 plot % 16 for 8*5 plot
    title(['Iteration ' num2str(i-1)], 'FontSize', 20) %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 Limits 0 1000]) 
    set(gca,'FontWeight','bold')
    set(gca, 'FontName', 'Times New Roman')
    %set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
end 
for i=50001:100000:499000 %1:Sockets % 1:Ranks
    Idle = CompStart(i:i+1000,:) - CompStop(i-1:i+1000-1,:);
    subplot(2,5,x)    
    hist(Idle(:,20),35)
    set(gca, 'FontSize', 32) % 32 1*4 plot % 16 for 8*5 plot
    title(['Iteration ' num2str(i-1)], 'FontSize', 20) %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 Limits 0 1000])   
    x=x+1;
    grid on
    set(gca,'FontWeight','bold')
    set(gca, 'FontName', 'Times New Roman')
    %set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
end 
print(fb, "Dist_snippet.pdf", '-dpdf','-bestfit');
system ("pdflatex Dist_snippet");
saveas(gcf,'Dist_snippet.png')
savefig(fullfile('resultdir', ['PhaseSpace_start' '.fig']));
open Dist_snippet.pdf
