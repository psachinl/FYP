clear
close all

algo = 'Reactive Delay';
number_of_runs = 10;
delay = 5;
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
str = sprintf('%s GTT as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d \n Broadcast Blocking Period = %ds',algo,number_of_runs,transmissions_per_sec,delay);
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
str = sprintf('%s ATPC as a function of Nodes per Group \n Simulation Runs = %d, Max Transmissions per Second = %d \n Broadcast Blocking Period = %ds',algo,number_of_runs,transmissions_per_sec,delay);
title(str);

n = 400;

blocking_period = [
    1
    2
    5
    10
    ];

bp1_GTT = [
    16
    18
    18
    17
    19
    16
    18
    17
    17
    17
    ];

bp2_GTT = [
    19
    21
    19
    18
    19
    23
    21
    23
    21
    21
    ];

bp5_GTT = [
    27
    27
    24
    27
    30
    26
    27
    31
    26
    27
    ];

bp10_GTT = [
    34
    34
    37
    40
    37
    33
    34
    36
    34
    34
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
    1.792500
    2.194500
    1.983500
    1.908000
    1.993500
    1.785500
    1.999500
    1.849500
    1.931000
    2.081000
    ];

bp2_ATPC = [
    1.187000
    1.199500
    1.154000
    1.080000
    1.189000
    1.295500
    1.281500
    1.336000
    1.236500
    1.275500
    ];

bp5_ATPC = [
    7.650000e-01
    8.485000e-01
    7.415000e-01
    8.080000e-01
    8.565000e-01
    7.260000e-01
    8.000000e-01
    9.310000e-01
    7.475000e-01
    8.330000e-01
    ];

bp10_ATPC = [
    6.015000e-01
    6.335000e-01
    6.845000e-01
    6.910000e-01
    6.655000e-01
    6.190000e-01
    6.090000e-01
    6.845000e-01
    6.130000e-01
    6.095000e-01
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

figure(3)
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

figure(4)
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
