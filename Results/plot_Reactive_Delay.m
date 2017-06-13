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
    3
    4
    5
    6
    7
    8
    9
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

bp3_GTT = [
    21
    20
    21
    23
    22
    23
    23
    22
    25
    22
    ];

bp4_GTT = [
    27
    22
    23
    24
    25
    22
    23
    26
    23
    26
    ];

bp5_GTT = [
    28
    26
    23
    27
    23
    24
    29
    26
    25
    28
    ];

bp6_GTT = [
    25
    27
    30
    29
    27
    28
    29
    27
    25
    32
    ];

bp7_GTT = [
    27
    26
    34
    31
    30
    25
    34
    31
    30
    31
    ];

bp8_GTT = [
    33
    35
    29
    31
    27
    30
    29
    37
    31
    35
    ];

bp9_GTT = [
    28
    31
    40
    36
    35
    28
    32
    36
    35
    32
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
    mean(bp3_GTT);
    mean(bp4_GTT);
    mean(bp5_GTT);
    mean(bp6_GTT);
    mean(bp7_GTT);
    mean(bp8_GTT);
    mean(bp9_GTT);
    mean(bp10_GTT);
    ];

bp_median_GTT = [
    median(bp1_GTT);
    median(bp2_GTT);
    median(bp3_GTT);
    median(bp4_GTT);
    median(bp5_GTT);
    median(bp6_GTT);
    median(bp7_GTT);
    median(bp8_GTT);
    median(bp9_GTT);
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

bp3_ATPC = [
    8.850000e-01
    8.690000e-01
    8.980000e-01
    1.042000
    9.455000e-01
    9.715000e-01
    1.016500
    9.700000e-01
    1.019000
    8.270000e-1
    ];

bp4_ATPC = [
    9.650000e-01
    7.675000e-01
    7.830000e-01
    8.265000e-01
    8.610000e-01
    7.495000e-01
    7.950000e-01
    8.910000e-01
    7.830000e-01
    8.455000e-01
    ];

bp5_ATPC = [
    8.270000e-01
    7.970000e-01
    6.860000e-01
    7.875000e-01
    8.305000e-01
    8.055000e-01
    7.630000e-01
    7.300000e-01
    7.545000e-01
    7.485000e-01
    ];

bp6_ATPC = [
    6.455000e-01
    7.110000e-01
    7.530000e-01
    7.175000e-01
    6.865000e-01
    7.390000e-01
    7.230000e-01
    7.025000e-01
    6.270000e-01
    8.005000e-01
    ];

bp7_ATPC = [
    6.815000e-01
    6.285000e-01
    7.385000e-01
    6.990000e-01
    6.840000e-01
    5.935000e-01
    7.480000e-01
    6.945000e-01
    6.745000e-01
    7.715000e-01
    ];

bp8_ATPC = [
    6.960000e-01
    7.320000e-01
    5.955000e-01
    6.580000e-01
    6.315000e-01
    6.090000e-01
    6.160000e-01
    7.075000e-01
    6.270000e-01
    7.760000e-01
    ];

bp9_ATPC = [
    5.480000e-01
    6.340000e-01
    5.715000e-01
    7.470000e-01
    6.785000e-01
    5.610000e-01
    6.385000e-01
    6.615000e-01
    7.210000e-01
    5.985000e-01
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
    mean(bp3_ATPC);
    mean(bp4_ATPC);
    mean(bp5_ATPC);
    mean(bp6_ATPC);
    mean(bp7_ATPC);
    mean(bp8_ATPC);
    mean(bp9_ATPC);
    mean(bp10_ATPC);
    ];

bp_median_ATPC = [
    median(bp1_ATPC);
    median(bp2_ATPC);
    median(bp3_ATPC);
    median(bp4_ATPC);
    median(bp5_ATPC);
    median(bp6_ATPC);
    median(bp7_ATPC);
    median(bp8_ATPC);
    median(bp9_ATPC);
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
