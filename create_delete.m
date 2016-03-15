create_csv = csvread('create_delete');

threads = create_csv ( :, [1]); 
time = create_csv ( :, [2]); 
time = time * 1000 * 1000;

average = time ./ threads;
table = [ threads  average ]