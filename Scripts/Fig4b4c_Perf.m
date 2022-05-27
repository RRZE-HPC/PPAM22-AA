clc;
close all;
clear all;

CompStart = dlmread('CompStart.txt');
CompStop =  dlmread('CompStop.txt');

size(CompStart)
size(CompStop)

Ranks=40; %1440 %40 %400
PPS=10;
Sockets=Ranks/PPS; % Ranks/36 % Ranks/10
Iterations=500001; %100000

Time = CompStart(2:end);
Time(end+1) = CompStop(end);
%Time = CompStart(1:end);

L1 = (repmat(1:Iterations,1,Ranks))';
Performance = L1./Time;
Performance = reshape(Performance,[Iterations,Ranks]); % Performance [iterations/second]

Pmin=17; %17/10 %20 %12 %46 %70 %180 %0 
Pmax=19; %19/30 %22 %16 %48 %90 %220 %4  

%% Overall view
x=1;
fa = figure('Renderer', 'painters', 'Position', [10 10 1200 700]) % 700 100 %  [x y width height]
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(8,5,i) %    subplot(8,5,i) % subplot(4,1,i)
    plot(Performance(:,i),'.')
    set(gca, 'FontSize', 16) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)], 'FontSize', 16) %20 1*4 plot %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 Iterations Pmin Pmax])  %   xlim([0 Iterations])
    x=x+PPS;
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
  %  set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
end 
print(fa, "Performance.pdf", '-dpdf','-bestfit');
system ("pdflatex Performance");
saveas(gcf,'Performance.png')
savefig(fullfile('resultdir', ['Performance' '.fig']));

%% Snippets view
x=1;
fa = figure('Renderer', 'painters', 'Position', [10 10 1200 700]) % 700 100 %  [x y width height]
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(4,1,i) %    subplot(8,5,i) % subplot(4,1,i)
    plot(Performance(1:1000,i),'.')
    set(gca, 'FontSize', 32) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)], 'FontSize', 20) %20 1*4 %16 for 8*5 plot plot %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 1000 Pmin Pmax])  %   xlim([0 Iterations])
    x=x+PPS;
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
  %  set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
end 
print(fa, "Performance-start1K.pdf", '-dpdf','-bestfit');
system ("pdflatex Performance-start1K");
saveas(gcf,'Performance-start1K.png')
savefig(fullfile('resultdir', ['Performance-start1K' '.fig']));

x=1;
fa = figure('Renderer', 'painters', 'Position', [10 10 1200 700]) % 700 100 %  [x y width height]
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(4,1,i) %    subplot(8,5,i) % subplot(4,1,i)
    plot(Performance(1:10000,i),'.')
    set(gca, 'FontSize', 32) % 32 1*4 plot % 16 for 8*5 plot
    title(['Socket ' num2str(i-1)], 'FontSize', 20) %20 1*4 %16 for 8*5 plot plot %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
    axis([0 10000 Pmin Pmax])  %   xlim([0 Iterations])
    x=x+PPS;
    set(gca, 'FontName', 'Times New Roman')
    set(gca,'FontWeight','bold')
  %  set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
end 
print(fa, "Performance-start10K.pdf", '-dpdf','-bestfit');
system ("pdflatex Performance-start10K");
saveas(gcf,'Performance-start10K.png')
savefig(fullfile('resultdir', ['Performance-start10K' '.fig']));


%% Histogram 
fb = figure('Renderer', 'painters', 'Position', [10 10 1200 700]) % 700 100 %  [x y width height]
for i=1:Sockets %1:Sockets % 1:Ranks 
    subplot(8,5,i)    
    hist(Performance(:,i),35)
    title(['Socket ' num2str(i-1)]) %title(['Socket ' num2str(i-1)]) %title(['Rank ' num2str(i-1)])
  %  axis([Pmin Pmax 0 Iterations])   
    grid on
end 
print(fb, "Perf_Dist.pdf", '-dpdf','-bestfit');
system ("pdflatex Perf_Dist");
saveas(gcf,'Perf_Dist.png')
savefig(fullfile('resultdir', ['Perf_Dist' '.fig']));