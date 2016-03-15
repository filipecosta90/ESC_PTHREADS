wait_csv = csvread('clean_busy_wait_8192.csv');
mutex_csv = csvread('clean_mutex_8192.csv');
semaphore_csv = csvread('clean_semaphore_8192.csv');

threads_wait = wait_csv ( :, [1]); 
threads_mutex = mutex_csv ( :, [1]); 
threads_semaphore = semaphore_csv ( :, [1]); 

time_wait = wait_csv ( :, [2]); 
time_wait = time_wait * 1000 * 1000;
time_mutex = mutex_csv ( :, [2]); 
time_mutex = time_mutex * 1000 * 1000;
time_semaphore = semaphore_csv ( :, [2]); 
time_semaphore = time_semaphore * 1000 * 1000;




 figure (1)


hFig = figure(1);

bg = [1 1 1; 0 0 0];
cores = distinguishable_colors(100,bg);

loglog(threads_wait,time_wait,'ro--','Color', cores(1,:),'MarkerSize', 12);
hold on;
loglog(threads_mutex,time_mutex,'r+--','Color', cores(2,:),'MarkerSize', 12);
hold on;
loglog(threads_semaphore,time_semaphore,'r*--','Color', cores(3,:),'MarkerSize', 12);
hold on;


grid on;
set(gca, 'XTick', [0 1 2 4 8 16 32 64 128 256]);
xlim([0,256]) ;
%ylim([0,1000]) ;

set(gca,'YTickLabel',num2str(get(gca,'YTick').'));

l = legend('BUSY - dataset 8192','MUTEX - dataset 8192' , 'SEMAFORO - dataset 8192','interpreter','latex');


set(l,'FontSize',12);
ylabel('Tempo $\mu$s','interpreter','latex');

xlabel('Num. POSIX Threads');
t = title({'Rela\c{c}\~ao entre n\''umero de fios de execu\c{c}\~ao e tempo total em $\mu$s para para os diferentes m\''etodos,\newline','n\''o compute-431, intervalo [0:8192], para compilador gcc 4.9.0 sem flags de otimiza\c{c}\~ao de compila\c{c}\~ao'},'interpreter','latex')

set(t,'FontSize',24);
set(gca,'fontsize',12);
set(hFig, 'Position', [0 0 640 480])

