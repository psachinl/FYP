clear
close all

algo = 'LMR';
number_of_runs = 10;
delay = 5;
transmissions_per_sec = 10;

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

mean_PTER = [
    2.6237
    1.7726
    1.0981
    0.5600
    0.3075
    0.3140
    ];

median_PTER = [
    0
    1.2660
    1.0333
    0.5324
    0.2686
    0.2419
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
str = sprintf('%s GTT as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d \n Route Discovery Delay = %ds',algo,number_of_runs,transmissions_per_sec,delay);
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
str = sprintf('%s ATPC as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d \n Route Discovery Delay = %ds',algo,number_of_runs,transmissions_per_sec,delay);
title(str);

figure(3)
hold on
plot(nodes,mean_PTER,'-x')
plot(nodes,median_PTER,'-o')
hold off
grid on
xlabel('Nodes per Group')
ylabel('Packet Transmission Error Rate (%)')
legend('Mean PTER', 'Median PTER', 'Location', 'best')
str = sprintf('%s PTER as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d \n Route Discovery Delay = %ds',algo,number_of_runs,transmissions_per_sec,delay);
title(str);

n = 400;

blocking_period = [
    1
    2
    5
    10
    ];

bp1_GTT = [
    42
    40
    43
    41
    42
    40
    43
    41
    40
    43
    ];

bp2_GTT = [
    41
    42
    42
    40
    41
    42
    40
    43
    42
    40
    ];

bp5_GTT = [
    43
    43
    43
    41
    43
    40
    42
    41
    41
    40
    ];

bp10_GTT = [
    40
    42
    41
    41
    42
    51
    41
    42
    42
    42
    ];

bp_mean_GTT = [
    mean(bp1_GTT);
    mean(bp2_GTT);
    mean(bp5_GTT);
    mean(bp10_GTT);
    ];

bp_median_GTT = [
    median(bp1_GTT);
    median(bp2_GTT);
    median(bp5_GTT);
    median(bp10_GTT);
    ];

bp1_ATPC = [
    5.802250
    6.095000
    5.807625
    5.730250
    5.695625
    5.655250
    5.827875
    5.912750
    5.800250
    5.933125
    ];

bp2_ATPC = [
    3.909875
    3.981125
    3.975625
    3.805625
    3.986875
    3.929000
    3.855500
    3.989125
    3.891875
    3.991500
    ];

bp5_ATPC = [
    2.721125
    2.737375
    2.720000
    2.822500
    2.779750
    2.641250
    2.840375
    2.896000
    2.667250
    2.699250
    ];

bp10_ATPC = [
    2.275750
    2.471250
    2.184500
    2.236000
    2.379875
    2.327250
    2.269375
    2.210750
    2.428500
    2.467750
    ];

bp_mean_ATPC = [
    mean(bp1_ATPC);
    mean(bp2_ATPC);
    mean(bp5_ATPC);
    mean(bp10_ATPC);
    ];

bp_median_ATPC = [
    median(bp1_ATPC);
    median(bp2_ATPC);
    median(bp5_ATPC);
    median(bp10_ATPC);
    ];

bp1_PTER = [
    1.320451
    2.060875
    1.631321
    7.096992e-01
    6.821282e-01
    1.081967
    1.601307
    1.636126
    1.611842
    1.393960
    ];

bp2_PTER = [
    5.208333e-01
    1.242642
    1.010441
    1.158940
    1.290739
    1.427149
    7.595773e-01
    1.553206
    1.537947
    7.521256e-01
    ];

bp5_PTER = [
    3.723764e-01
    1.343183e-01
    3.105590e-01
    6.983240e-02
    3.529827e-02
    5.343783e-01
    1.732502e-01
    8.981002e-01
    1.708817e-01
    4.409769e-01
    ];

bp10_PTER = [
    2.076843e-01
    6.966214e-01
    2.451839e-01
    4.492053e-01
    5.135228e-01
    1.745201e-01
    6.985679e-02
    1.057828e-01
    1.709402e-01
    6.915629e-01
    ];

bp_mean_PTER = [
    mean(bp1_PTER);
    mean(bp2_PTER);
    mean(bp5_PTER);
    mean(bp10_PTER);
    ];

bp_median_PTER = [
    median(bp1_PTER);
    median(bp2_PTER);
    median(bp5_PTER);
    median(bp10_PTER);
    ];

figure(4)
hold on
plot(blocking_period,bp_mean_GTT,'-x')
plot(blocking_period,bp_median_GTT,'-o')
hold off
grid on
xlabel('Broadcast Blocking Period Duration (s)')
ylabel('Group Transmission Time (s)')
legend('Mean GTT', 'Median GTT', 'Location', 'best')
str = sprintf('%s GTT as a function of Broadcast Blocking Period \n Simulation Runs = %d, Max Transmissions per Second = %d \n Nodes per Group = %d',algo,number_of_runs,transmissions_per_sec,400);
title(str);

figure(5)
hold on
plot(blocking_period,bp_mean_ATPC,'-x')
plot(blocking_period,bp_median_ATPC,'-o')
hold off
grid on
xlabel('Broadcast Blocking Period Duration (s)')
ylabel('Average Transmission Power Consumption (W)')
legend('Mean ATPC', 'Median ATPC', 'Location', 'best')
str = sprintf('%s ATPC as a function of Broadcast Blocking Period \n Simulation Runs = %d, Max Transmissions per Second = %d \n Nodes per Group = %d',algo,number_of_runs,transmissions_per_sec,400);
title(str);

figure(6)
hold on
plot(blocking_period,bp_mean_PTER,'-x')
plot(blocking_period,bp_median_PTER,'-o')
hold off
grid on
xlabel('Broadcast Blocking Period Duration (s)')
ylabel('Packet Transmission Error Rate (%)')
legend('Mean PTER', 'Median PTER', 'Location', 'best')
str = sprintf('%s PTER as a function of Broadcast Blocking Period \n Simulation Runs = %d, Max Transmissions per Second = %d \n Nodes per Group = %d',algo,number_of_runs,transmissions_per_sec,400);
title(str);
