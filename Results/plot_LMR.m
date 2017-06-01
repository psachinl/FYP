clear
close all

algo = 'LMR';
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
    125.9000
    107.3000
    82.8000
    49.5000
    43.8000
    41.7000
    ];

median_GTT = [
    126
    101.5000
    84
    51
    42.5000
    41.5000
    ];

mean_ATPC = [
    3.1830
    2.6516
    2.3847
    1.9515
    2.2572
    2.7525
    ];

median_ATPC = [
    3.2512
    2.6320
    2.5580
    1.9650
    2.2113
    2.7292
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
str = sprintf('%s Group Transmission Time as a function of Nodes per Group \n Simulation Runs = %d, Route Discovery Delay = %ds',algo,number_of_runs,delay);
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
str = sprintf('%s ATPC as a function of Nodes per Group \n Simulation Runs = %d, Broadcast Delay = %ds',algo,number_of_runs,delay);
title(str);
