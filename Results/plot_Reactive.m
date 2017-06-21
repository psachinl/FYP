clear
close all

algo = 'Reactive';
number_of_runs = 10;
transmissions_per_sec = 1;

nodes = [
    20
    50
    100
    200
    300
    400
    ];

mean_GTT = [
    108.5000
    78.6000
    44
    19.4000
    18.9000
    17.5
    ];

median_GTT = [
    111
    76
    42
    19
    18
    17.5
    ];

mean_ATPC = [
    11.5540
    9.4820
    5.1234
    2.1268
    1.9851
    1.8965
    ];

median_ATPC = [
    11.2450
    9.2780
    3.5320
    2.2020
    1.9790
    1.8920
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
str = sprintf('%s GTT as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d',algo,number_of_runs,transmissions_per_sec);
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
str = sprintf('%s ATPC as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d',algo,number_of_runs,transmissions_per_sec);
title(str);
