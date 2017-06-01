clear
close all

% 400 nodes per group results

n = 400;
plot_figs = true;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    6
    7
    5
    6
    5
    6
    NaN
    NaN
    NaN
    NaN
    ];

active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active{5} = [ % Average Transmission Power Consumption (ATPC)
    1.528883e+01
    1.811683e+01
    1.053250e+01
    1.407408e+01
    1.112733e+01
    1.540525e+01
    NaN
    NaN
    NaN
    NaN
    ];

active{6} = mean(active{5}); % Mean ATPC
active{7} = median(active{5}); % Median ATPC
active{8} = range(active{5}); % Range

active{9} = [ % Simulation times
    969.411918
    927.319520
    941.692744
    954.293021
    920.202670
    931.410588
    NaN
    NaN
    NaN
    NaN
    ];

active{10} = mean(active{9}); % Mean simulation time

reactive{1} = [ % Reactive GTT
    17
    17
    17
    20
    22
    16
    18
    18
    18
    26
    ];

reactive{2} = mean(reactive{1});
reactive{3} = median(reactive{1}); 
reactive{4} = range(reactive{1});

reactive{5} = [ % Average Transmission Power Consumption (ATPC)
    1.990000
    1.985333
    1.859333
    2.473333
    2.077333
    1.710000
    1.972667
    1.986000
    1.950667
    1.846000
    ];

reactive{6} = mean(reactive{5}); % Mean ATPC
reactive{7} = median(reactive{5}); % Median ATPC
reactive{8} = range(reactive{5}); % Range

reactive{9} = [ % Simulation times
    15.382582
    14.720400
    14.141273
    17.416028
    15.194260
    13.703490
    14.796759
    16.458309
    15.044999
    14.295620
    ];

reactive{10} = mean(reactive{9}); % Mean simulation time

reactive_delay{1} = [ % Reactive_delay GTT
    29
    31
    26
    31
    33
    27
    32
    29
    35
    30
    ];

reactive_delay{2} = mean(reactive_delay{1});
reactive_delay{3} = median(reactive_delay{1});
reactive_delay{4} = range(reactive_delay{1});

reactive_delay{5} = [ % Average Transmission Power Consumption (ATPC)
    7.920000e-01
    9.446667e-01
    7.726667e-01
    7.613333e-01
    9.553333e-01
    7.966667e-01
    7.800000e-01
    8.626667e-01
    8.233333e-01
    7.993333e-01
    ];

reactive_delay{6} = mean(reactive_delay{5}); % Mean ATPC
reactive_delay{7} = median(reactive_delay{5}); % Median ATPC
reactive_delay{8} = range(reactive_delay{5}); % Range

reactive_delay{9} = [ % Simulation times
    9.932588
    10.706332
    9.664438
    9.973018
    10.758033
    10.101520
    9.896118
    10.402081
    10.100132
    9.811020
    ];

reactive_delay{10} = mean(reactive_delay{9}); % Mean simulation time

lmr{1} = [ % LMR GTT
    54
    45
    42
    43
    42
    42
    43
    42
    42
    43
    ];

lmr{2} = mean(lmr{1}); % Mean GTT
lmr{3} = median(lmr{1}); % Median GTT
lmr{4} = range(lmr{1}); % Range

lmr{5} = [ % Average Transmission Power Consumption (ATPC)
    2.410167
    2.294167
    2.177833
    2.213500
    2.295167
    2.209167
    2.188500
    2.201667
    2.187167
    2.394667
    ];

lmr{6} = mean(lmr{5}); % Mean ATPC
lmr{7} = median(lmr{5}); % Median ATPC
lmr{8} = range(lmr{5}); % Range

lmr{9} = [ % Simulation times
    18.453159
    17.270835
    16.855500
    17.683776
    18.506489
    17.531139
    17.575621
    17.186333
    16.946625
    17.546040
    ];

lmr{10} = mean(lmr{9}); % Mean simulation time

lmr{11} = [ % Packet Transmission Error Rate (PTER)
    9.808983e-01
    5.704507e-02
    1.667593e-01
    2.721829e-01
    1.104362e-01
    3.359462e-01
    3.314917e-01
    3.873824e-01
    1.683502e-01
    2.649709e-01
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
