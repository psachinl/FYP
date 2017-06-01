clear
close all

algo = 'DREAM';
number_of_runs = 10;

nodes = [
    20
    50
    100
    200
    300
    400
    ];

mean_GTT = [
    103.8000
    69
    31.6000
    9
    NaN
    NaN
    ];

median_GTT = [
    104
    67
    29
    8.5
    NaN
    NaN
    ];

mean_ATPC = [
    24.8286
    44.8131
    32.5687
    14.6499
    NaN
    NaN
    ];

median_ATPC = [
    25.3588
    40.2763
    22.3173
    13.8755
    NaN
    NaN
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
str = sprintf('%s Group Transmission Time as a function of Nodes per Group \n Simulation Runs = %d',algo,number_of_runs);
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
str = sprintf('%s ATPC as a function of Nodes per Group \n Simulation Runs = %d',algo,number_of_runs);
title(str);
