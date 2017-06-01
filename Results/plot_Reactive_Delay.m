clear
close all

algo = 'Reactive Delay';
number_of_runs = 10;
delay = 5;

nodes = [
    20
    50
    100
    200
    300
    400
    ];

mean_GTT = [
    128.2
    102.9000
    57.7000
    36.2000 
    30.3000
    27.2000
    ];

median_GTT = [
    126.5
    103.5
    57.5000
    35.5000
    30.5000
    27
    ];

mean_ATPC = [
    3.0570
    2.4548
    1.5386
    0.9977
    0.8288
    0.8057
    ];

median_ATPC = [
    2.99
    2.4280
    1.4110
    0.9540
    0.7980
    0.8040
    ];

figure(1)
hold on
plot(nodes,mean_GTT,'-x')
plot(nodes,median_GTT,'-o')
hold off
grid on
xlabel('Nodes per Group')
ylabel('Group Transmission Time (s)')
legend('Mean Group Transmission Time', 'Median Group Transmission Time', 'Location', 'best')
str = sprintf('%s GTT as a function of Nodes per Group \n Simulation Runs = %d, Broadcast Block = %ds',algo,number_of_runs,delay);
title(str);

figure(2)
hold on
plot(nodes,mean_ATPC,'-x')
plot(nodes,median_ATPC,'-o')
hold off
grid on
xlabel('Nodes per Group')
ylabel('Average Transmission Power Consumption (W)')
legend('Mean ATPC', 'Median ATPC', 'Location', 'best')
str = sprintf('%s ATPC as a function of Nodes per Group \n Simulation Runs = %d, Broadcast Block = %ds',algo,number_of_runs,delay);
title(str);
