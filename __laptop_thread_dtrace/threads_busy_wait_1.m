clear all
close all

%ganttData = importdata('gantt.csv');

ganttData.data = [0 1 2 3 4; 4 5 6 7 8; 4 5 6 7 9];

V = ganttData.data(:,1);
slots = ganttData.data(:,2:end);

for i = length(slots(1,:)):-1:2
    for j = 1:1:length(slots(:,1))
        if slots(j,i) > 0
           slots(j,i) = slots(j,i)-slots(j,i-1); 
        end
    end
end

figure;
h = barh(V,slots,'stacked','k','LineStyle','none');
title('Diagrama de Cria??o de fios de execu??o (POSIX Threads) para processo ');
xlabel('Microsenconds since Process Start');
ylabel('Activity');
set(gca, 'YDir', 'reverse');
set(gca, 'YTick', 1:1:length(V));

for i = 1:1:length(V)
    if mod(i,2) ~= 0
        set(h(i),'FaceColor',[0.8 0.8 0.8]); 
    end
end