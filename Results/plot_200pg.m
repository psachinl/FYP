clear
close all

% 200 nodes per group results

n = 200;
plot_figs = true;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    7
    10
    9
    11
    7
    7
    12
    11
    8
    8
    ];

active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active{5} = [ % Average Transmission Power Consumption (ATPC)
    1.131112e+01
    1.338700e+01
    1.631650e+01
    1.598575e+01
    1.208575e+01
    1.040575e+01
    1.792800e+01
    2.176012e+01
    1.295475e+01
    1.436400e+01
    ];

active{6} = mean(active{5}); % Mean ATPC
active{7} = median(active{5}); % Median ATPC
active{8} = range(active{5}); % Range

active{9} = [ % Simulation times
    435.891095
    442.106141
    435.982154
    441.882721
    439.100245
    435.052204
    444.374777
    449.010474
    455.125519
    450.055414
    ];

active{10} = mean(active{9}); % Mean simulation time

reactive{1} = [ % Reactive GTT
    19
    18
    16
    19
    21
    27
    18
    17
    20
    19
    ];

reactive{2} = mean(reactive{1});
reactive{3} = median(reactive{1}); 
reactive{4} = range(reactive{1});

reactive{5} = [ % Average Transmission Power Consumption (ATPC)
    2.198000
    2.138000
    1.761000
    2.206000
    2.396000
    2.227000
    1.979000
    1.927000
    2.215000
    2.221000
    ];

reactive{6} = mean(reactive{5}); % Mean ATPC
reactive{7} = median(reactive{5}); % Median ATPC
reactive{8} = range(reactive{5}); % Range

reactive{9} = [ % Simulation times
    8.909492
    9.266865
    8.115588
    8.825730
    9.152797
    9.057849
    8.394449
    8.378780
    8.868725
    8.785858
    ];

reactive{10} = mean(reactive{9}); % Mean simulation time

reactive_delay{1} = [ % Reactive_delay GTT
    50
    35
    33
    37
    33
    36
    36
    31
    34
    37
    ];

reactive_delay{2} = mean(reactive_delay{1});
reactive_delay{3} = median(reactive_delay{1});
reactive_delay{4} = range(reactive_delay{1});

reactive_delay{5} = [ % Average Transmission Power Consumption (ATPC)
    1.325000
    9.190000e-01
    9.290000e-01
    1.095000
    9.180000e-01
    9.610000e-01
    1.087000
    7.270000e-01
    9.470000e-01
    1.069000
    ];

reactive_delay{6} = mean(reactive_delay{5}); % Mean ATPC
reactive_delay{7} = median(reactive_delay{5}); % Median ATPC
reactive_delay{8} = range(reactive_delay{5}); % Range

reactive_delay{9} = [ % Simulation times
    7.585059
    6.654017
    6.632387
    7.174379
    6.714538
    6.788273
    7.075699
    6.440579
    6.838890
    7.010209
    ];

reactive_delay{10} = mean(reactive_delay{9}); % Mean simulation time

lmr{1} = [ % LMR GTT
    52
    51
    44
    51
    56
    49
    51
    46
    44
    51
    ];

lmr{2} = mean(lmr{1}); % Mean GTT
lmr{3} = median(lmr{1}); % Median GTT
lmr{4} = range(lmr{1}); % Range

lmr{5} = [ % Average Transmission Power Consumption (ATPC)
    1.794250
    1.822750
    1.936500
    1.993500
    2.050000
    2.260500
    1.830000
    1.995000
    1.839000
    1.993500
    ];

lmr{6} = mean(lmr{5}); % Mean ATPC
lmr{7} = median(lmr{5}); % Median ATPC
lmr{8} = range(lmr{5}); % Range

lmr{9} = [ % Simulation times
    9.706510
    9.706466
    9.922458
    10.084820
    10.508358
    10.846792
    9.870624
    10.145962
    9.666161
    10.094322
    ];

lmr{10} = mean(lmr{9}); % Mean simulation time

lmr{11} = [ % Packet Transmission Error Rate (PTER)
    4.756243e-01
    4.878049e-01
    2.298851e-01
    1.006711
    6.578947e-01
    5.769231e-01
    3.554502e-01
    7.592191e-01
    2.484472e-01
    8.018328e-01
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
    xlabel('Simulation Run')
    ylabel('Group Transmission Time (s)')
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
    xlabel('Simulation Run')
    ylabel('Average Transmission Power Consumption (W)')
    legend('DREAM', 'Reactive', 'Reactive Delay', 'LMR', 'Location', 'best')
    str = sprintf('Average Transmission Power Consumption for all algorithms \n %d nodes per group, 10 simulation runs',n);
    title(str);
    
    figure(3)
    plot(lmr{11},'x')
    xlabel('Simulation Run')
    ylabel('Packet Transmission Error Rate (%)')
    str = sprintf('LMR Packet Transmission Error Rate, %d nodes per group, \n route discovery blocking period = 5 seconds, 10 simulation runs \n mean = %f%%',n,lmr{12});
    title(str);
end
