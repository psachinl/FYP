clear
close all

% 20 nodes per group results

n = 20;
plot_figs = false;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    105
    112
    137
    105
    77
    96
    97
    116
    103
    90
    ];

active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active{5} = [ % Average Transmission Power Consumption (ATPC)
    2.566500e+01
    2.577875e+01
    2.821500e+01
    2.475750e+01
    1.615125e+01
    2.757500e+01
    2.053125e+01
    2.505250e+01
    3.763375e+01
    1.692625e+01
    ];

active{6} = mean(active{5}); % Mean ATPC
active{7} = median(active{5}); % Median ATPC
active{8} = range(active{5}); % Range

active{9} = [ % Simulation times
    10.665851
    9.456985
    9.908964
    9.519795
    8.208397
    8.658922
    8.343997
    8.894727
    9.101123
    8.060856
    ];

active{10} = mean(active{9}); % Mean simulation time

reactive{1} = [ % Reactive GTT
    122
    121
    79
    90
    109
    119
    111
    111
    102
    121
    ];

reactive{2} = mean(reactive{1});
reactive{3} = median(reactive{1}); 
reactive{4} = range(reactive{1});

reactive{5} = [ % Average Transmission Power Consumption (ATPC)
    1.348000e+01
    1.326000e+01
    8.830000
    1.248000e+01
    1.108000e+01
    1.319000e+01
    1.126000e+01
    1.088000e+01
    9.850000
    1.123000e+01
    ];

reactive{6} = mean(reactive{5}); % Mean ATPC
reactive{7} = median(reactive{5}); % Median ATPC
reactive{8} = range(reactive{5}); % Range

reactive{9} = [ % Simulation times
    3.103414
    2.972935
    2.967651
    3.259499
    3.267903
    3.476423
    3.498229
    2.955953
    2.843714
    2.845419
    ];

reactive{10} = mean(reactive{9}); % Mean simulation time

reactive_delay{1} = [ % Reactive_delay GTT
    123
    106
    114
    150
    112
    148
    135
    126
    141
    127
    ];

reactive_delay{2} = mean(reactive_delay{1});
reactive_delay{3} = median(reactive_delay{1});
reactive_delay{4} = range(reactive_delay{1});

reactive_delay{5} = [ % Average Transmission Power Consumption (ATPC)
    3.550000
    2.940000
    3.040000
    3.090000
    2.540000
    2.870000
    3.750000
    2.820000
    2.870000
    3.100000
    ];

reactive_delay{6} = mean(reactive_delay{5}); % Mean ATPC
reactive_delay{7} = median(reactive_delay{5}); % Median ATPC
reactive_delay{8} = range(reactive_delay{5}); % Range

reactive_delay{9} = [ % Simulation times
    3.380407
    2.931737
    3.164343
    3.389246
    3.231362
    3.607554
    3.538174
    3.028552
    3.283915
    3.375532
    ];

reactive_delay{10} = mean(reactive_delay{9}); % Mean simulation time

lmr{1} = [ % LMR GTT
    145
    107
    131
    121
    121
    142
    111
    111
    132
    138
    ];

lmr{2} = mean(lmr{1}); % Mean GTT
lmr{3} = median(lmr{1}); % Median GTT
lmr{4} = range(lmr{1}); % Range

lmr{5} = [ % Average Transmission Power Consumption (ATPC)
    3.150000
    3.095000
    3.500000
    2.430000
    2.880000
    3.872500
    2.770000
    3.352500
    3.382500
    3.397500
    ];

lmr{6} = mean(lmr{5}); % Mean ATPC
lmr{7} = median(lmr{5}); % Median ATPC
lmr{8} = range(lmr{5}); % Range

lmr{9} = [ % Simulation times
    4.294437
    4.092404
    3.849264
    4.448872
    3.813960
    3.978560
    3.734317
    4.797563
    4.493838
    3.876157
    ];

lmr{10} = mean(lmr{9}); % Mean simulation time

lmr{11} = [ % Packet Transmission Error Rate (PTER)
    0
    0
    0
    0
    3.846154
    0
    5
    0
    8.695652
    8.695652
    ];

lmr{12} = mean(lmr{11}); % Mean PTER
lmr{13} = median(lmr{11}); % Median PTER
lmr{14} = range(lmr{11}); % Range

if plot_figs
    
    figure(1)
    hold on
    plot(active{1},'x')
    plot(reactive{1},'o')
    plot(reactive_delay{1},'*')
    plot(lmr{1},'.')
    hold off
    grid on
    xlabel('Simulation Run')
    ylabel('Group Transmission Time (s)')
%     ylim([0 200])
    legend('DREAM', 'Reactive', 'Reactive Delay', 'LMR', 'Location', 'best')
    str = sprintf('Group Transmission Time for all algorithms \n %d nodes per group, 10 simulation runs',n);
    title(str);
    
    figure(2)
    hold on
    plot(active{5},'x')
    plot(reactive{5},'o')
    plot(reactive_delay{5},'*')
    plot(lmr{5},'.')
    hold off
    grid on
    xlabel('Simulation Run')
    ylabel('Average Transmission Power Consumption (W)')
    legend('DREAM', 'Reactive', 'Reactive Delay', 'LMR', 'Location', 'best')
    str = sprintf('Average Transmission Power Consumption for all algorithms \n %d nodes per group, 10 simulation runs',n);
    title(str);
    
    figure(3)
    plot(lmr{11},'x')
    grid on
    xlabel('Simulation Run')
    ylabel('Packet Transmission Error Rate (%)')
    str = sprintf('LMR Packet Transmission Error Rate, %d nodes per group, \n route discovery blocking period = 5 seconds, 10 simulation runs \n mean = %f%%',n,lmr{12});
    title(str);
end
