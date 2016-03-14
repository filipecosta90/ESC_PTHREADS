wait_csv = csvread('clean_busy_wait_1024.csv');
mutex_csv = csvread('clean_mutex_1024.csv');
semaphore_csv = csvread('clean_semaphore_1024.csv');

threads_wait = wait_csv ( :, [1]); 
threads_mutex = mutex_csv ( :, [1]); 
threads_semaphore = semaphore_csv ( :, [1]); 

time_wait = wait_csv ( :, [2]); 
time_wait = time_wait * 1000 * 1000;
time_mutex = mutex_csv ( :, [2]); 
time_mutex = time_mutex * 1000 * 1000;
time_semaphore = semaphore_csv ( :, [2]); 
time_semaphore = time_semaphore * 1000 * 1000;


bg = [1 1 1; 0 0 0];
cores = distinguishable_colors(100,bg);

loglog(threads_wait,time_wait,'ro--','Color', cores(1,:),'MarkerSize', 12);
hold on;
loglog(threads_mutex,time_mutex,'r+--','Color', cores(2,:),'MarkerSize', 12);
hold on;
loglog(threads_semaphore,time_semaphore,'r*--','Color', cores(3,:),'MarkerSize', 12);
hold on;


grid on;
set(gca, 'XTick', [0 1 2 4 8 16 32 64 128 ]);
xlim([0,128]) ;
%ylim([0,1000]) ;


set(gca,'YTickLabel',num2str(get(gca,'YTick').'));


l = legend('BUSY','MUTEX' , 'SEMAPHORE');


  




set(l,'FontSize',12);
ylabel('Tempo (segundos)');

xlabel('Num. Threads OpenMP');
t = title({'Rela\c{c}\~ao entre Tempo Total em segundos para o kernel OMP - CG','Classe de dados C para compilador gcc 4.9.0 com flags de compila\c{c}\~ao -O3'},'interpreter','latex')

set(t,'FontSize',24);
set(gca,'fontsize',12);
