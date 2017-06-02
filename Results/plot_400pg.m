clear
close all

% 400 nodes per group results

n = 400;
plot_figs = false;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    5
    4
    3
    4
    3
    3
    5
    4
    3
    3
    ];

active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active{5} = [ % Average Transmission Power Consumption (ATPC)
    1.449956e+01
    1.165031e+01
    8.436625
    1.165031e+01
    8.436625
    8.316875
    1.555756e+01
    1.165031e+01
    8.436625
    8.316875
    ];

active{6} = mean(active{5}); % Mean ATPC
active{7} = median(active{5}); % Median ATPC
active{8} = range(active{5}); % Range

active{9} = [ % Simulation times
    1620.237727
    1668.068461
    1686.724284
    1610.203310
    1579.326042
    1605.735511
    1616.035105
    1537.134236
    1531.066097
    1557.070322
    ];

active{10} = mean(active{9}); % Mean simulation time

reactive{1} = [ % Reactive GTT
    18
    17
    17
    17
    16
    16
    18
    18
    19
    19
    ];

reactive{2} = mean(reactive{1});
reactive{3} = median(reactive{1}); 
reactive{4} = range(reactive{1});

reactive{5} = [ % Average Transmission Power Consumption (ATPC)
    2.051000
    1.876500
    1.853500
    1.943000
    1.709000
    1.782000
    1.907500
    2.076500
    1.972500
    1.794000
    ];

reactive{6} = mean(reactive{5}); % Mean ATPC
reactive{7} = median(reactive{5}); % Median ATPC
reactive{8} = range(reactive{5}); % Range

reactive{9} = [ % Simulation times
    22.800702
    21.753808
    21.913386
    21.468945
    20.255719
    20.538378
    20.854495
    22.233463
    22.019107
    19.939131
    ];

reactive{10} = mean(reactive{9}); % Mean simulation time

reactive_delay{1} = [ % Reactive_delay GTT
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

reactive_delay{2} = mean(reactive_delay{1});
reactive_delay{3} = median(reactive_delay{1});
reactive_delay{4} = range(reactive_delay{1});

reactive_delay{5} = [ % Average Transmission Power Consumption (ATPC)
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

reactive_delay{6} = mean(reactive_delay{5}); % Mean ATPC
reactive_delay{7} = median(reactive_delay{5}); % Median ATPC
reactive_delay{8} = range(reactive_delay{5}); % Range

reactive_delay{9} = [ % Simulation times
    12.467325
    16.178299
    15.002048
    14.832484
    13.525919
    12.015867
    12.432039
    13.694555
    12.220175
    12.863725
    ];

reactive_delay{10} = mean(reactive_delay{9}); % Mean simulation time

lmr{1} = [ % LMR GTT
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

lmr{2} = mean(lmr{1}); % Mean GTT
lmr{3} = median(lmr{1}); % Median GTT
lmr{4} = range(lmr{1}); % Range

lmr{5} = [ % Average Transmission Power Consumption (ATPC)
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

lmr{6} = mean(lmr{5}); % Mean ATPC
lmr{7} = median(lmr{5}); % Median ATPC
lmr{8} = range(lmr{5}); % Range

lmr{9} = [ % Simulation times
    27.756508
    25.768196
    25.276979
    24.838953
    25.183681
    23.955427
    24.955328
    25.456125
    24.409504
    25.456488
    ];

lmr{10} = mean(lmr{9}); % Mean simulation time

lmr{11} = [ % Packet Transmission Error Rate (PTER)
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
