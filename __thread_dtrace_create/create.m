threads_csv = readtable('THREAD_DTRACE_CREATE_256.csv','ReadVariableNames',false);
thread_ids = table2array( threads_csv ( :, [1])); 
thread_start = table2array( threads_csv ( :, [5])); 
thread_duration = table2array( threads_csv ( :, [4])); 
thread_start = thread_start / 1000;
thread_duration = thread_duration / 1000;
thread_stop = thread_start + thread_duration;
thread_idx =  [0 : length(thread_ids)-1] ;
thread_startx = transpose (thread_start);
thread_stopx = transpose (thread_stop);

a = thread_duration ( 2 : length(thread_duration) , : );
media = mean ( a );
desvio = std( a );

figure (1)


hFig = figure(1);


linewidth = 400 / length(thread_ids);

plot([thread_startx ; thread_stopx],[1 ;1 ] * thread_idx, 'LineWidth',10)
hold on;
ylim([-0.5 length(thread_ids)-0.5]);
xlim([0 thread_duration(1,1)]);

ylabel('Thread ID');
xlabel('Tempo (ms)','interpreter','latex');
t = title({'Rela\c{c}\~ao entre cria\c{c}\~ao de fios de execu\c{c}\~ao e tempo total em mili-segundos para conclus\~ao do Processo, 32 POSIX Threads,\newline','PERSONAL LAPTOP, para compilador gcc 4.9.0 sem flags de otimiza\c{c}\~ao de compila\c{c}\~ao'},'interpreter','latex')

%title({'Diagrama de cria\c{c}\~ao de fios de execu\c{c}\~ao, '},'interpreter','latex')
set(gca, 'YTick', [0 : 1 : length(thread_ids)-1])

set(hFig, 'Position', [0 0 680 680])
