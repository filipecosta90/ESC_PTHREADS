wait_csv = csvread('busy_wait.csv');
mutex_csv = csvread('mutex.csv');
semaphore_csv = csvread('semaphore.csv');
omp_csv = csvread('omp.csv');


threads_wait = wait_csv ( :, [1]); 
threads_mutex = mutex_csv ( :, [1]); 
threads_semaphore = semaphore_csv ( :, [1]); 
threads_omp = omp_csv ( :, [1]); 


time_wait = wait_csv ( :, [2]); 
time_wait = time_wait * 1000 * 1000;
time_mutex = mutex_csv ( :, [2]); 
time_mutex = time_mutex * 1000 * 1000;
time_semaphore = semaphore_csv ( :, [2]); 
time_semaphore = time_semaphore * 1000 * 1000;
time_omp = omp_csv ( :, [2]); 
time_omp = time_omp * 1000 * 1000;




 figure (1)


hFig = figure(1);

bg = [1 1 1; 0 0 0];
cores = distinguishable_colors(100,bg);

semilogx(threads_wait,time_wait,'ro--','Color', cores(1,:),'LineWidth',2, 'MarkerSize', 12);
hold on;
semilogx(threads_mutex,time_mutex,'r+--','Color', cores(2,:), 'LineWidth',2 ,'MarkerSize', 12);
hold on;
semilogx(threads_semaphore,time_semaphore,'r*--','Color',  cores(7,:), 'LineWidth',2, 'MarkerSize', 12);
hold on;
semilogx(threads_omp,time_omp,'ro--','Color',  cores(4,:), 'LineWidth',2, 'MarkerSize', 12);
hold on;


grid on;
set(gca, 'XTick', [0 1 2 4 8 16 32 64 128 256]);
hold on;

xlim([0,256]) ;
hold on;

%ylim([0 , 2000000]) ;
hold on;


set(gca,'YTickLabel',num2str(get(gca,'YTick').'));
hold on;

l = legend('BUSY','MUTEX' , 'SEMAFORO','OpenMP','interpreter','latex');


set(l,'FontSize',12);
ylabel('Tempo $\mu$s','interpreter','latex');

xlabel('Num. POSIX Threads / Num. OpenMp Threads');
t = title({'Rela\c{c}\~ao entre n\''umero de fios de execu\c{c}\~ao e tempo total em $\mu$s para para os diferentes m\''etodos PTHREADS vs OpenMP, n\''os compute-431 \newline','a:0, b: 1073741824, n: 1048576, para compilador gcc 4.9.0 sem flags de otimiza\c{c}\~ao de compila\c{c}\~ao'},'interpreter','latex')

set(t,'FontSize',24);
set(gca,'fontsize',12);
set(hFig, 'Position', [0 0 960 720])

