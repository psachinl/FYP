clear
close all

number_of_runs = 10;

nodes = [
    20
    50
    100
    200
    300
    400
    ];

DREAM_mean_GTT = [
    103.8000
    69
    31.6000
    9
    6
    3.7
    ];

Reactive_mean_GTT = [
    108.5000
    78.6000
    44
    19.4000
    18.9000
    17.5
    ];

Reactive_Delay_mean_GTT = [
    128.2
    102.9000
    57.7000
    36.2000 
    30.3000
    27.2000
    ];

LMR_mean_GTT = [
    125.9000
    107.3000
    82.8000
    49.5000
    43.8000
    41.7000
    ];

DREAM_mean_ATPC = [
    24.8286
    44.8131
    32.5687
    14.6499
    14.0950
    10.6952
    ];

Reactive_mean_ATPC = [
    11.5540
    9.4820
    5.1234
    2.1268
    1.9851
    1.8965
    ];

Reactive_Delay_mean_ATPC = [
    3.0570
    2.4548
    1.5386
    0.9977
    0.8288
    0.8057
    ];

LMR_mean_ATPC = [
    3.1830
    2.6516
    2.3847
    1.9515
    2.2572
    2.7525
    ];

figure(1)
hold on
plot(nodes,DREAM_mean_GTT,'-x')
plot(nodes,Reactive_mean_GTT,'-x')
plot(nodes,Reactive_Delay_mean_GTT,'-x')
plot(nodes,LMR_mean_GTT,'-x')
hold off
grid on
xlabel('Nodes per Group')
ylabel('Group Transmission Time (s)')
legend('DREAM', 'Reactive', 'Reactive Delay', 'LMR', 'Location', 'best')
str = sprintf('Group Transmission Time as a function of Nodes per Group \n Simulation Runs = %d, default parameters',number_of_runs);
title(str);

figure(2)
hold on
plot(nodes,DREAM_mean_ATPC,'-x')
plot(nodes,Reactive_mean_ATPC,'-x')
plot(nodes,Reactive_Delay_mean_ATPC,'-x')
plot(nodes,LMR_mean_ATPC,'-x')
hold off
grid on
xlabel('Nodes per Group')
ylabel('Average Transmission Power Consumption (W)')
legend('DREAM', 'Reactive', 'Reactive Delay', 'LMR', 'Location', 'best')
str = sprintf('Average Transmission Power Consumption as a function of Nodes per Group \n Simulation Runs = %d, default parameters',number_of_runs);
title(str);
