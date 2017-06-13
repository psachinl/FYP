clear
close all

% 100 nodes per group results

n = 100;
plot_figs = 1;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    29
    15
    21
    52
    53
    31
    29
    28
    40
    18
    ];

active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active{5} = [ % Average Transmission Power Consumption (ATPC)
    2.193800e+01
    1.311950e+01
    1.785225e+01
    7.673900e+01
    7.367100e+01
    2.226525e+01
    2.236925e+01
    3.237675e+01
    2.968375e+01
    1.567225e+01
    ];

active{6} = mean(active{5}); % Mean ATPC
active{7} = median(active{5}); % Median ATPC
active{8} = range(active{5}); % Range

active{9} = [ % Simulation times
    119.974096
    112.664051
    118.429393
    142.125749
    135.990389
    120.945421
    121.121650
    125.714186
    122.264300
    123.662824
    ];

active{10} = mean(active{9}); % Mean simulation time

reactive{1} = [ % Reactive GTT
    61
    29
    41
    29
    56
    49
    43
    37
    31
    64
    ];

reactive{2} = mean(reactive{1});
reactive{3} = median(reactive{1}); 
reactive{4} = range(reactive{1});

reactive{5} = [ % Average Transmission Power Consumption (ATPC)
    8.058000
    2.774000
    2.948000
    2.916000
    7.540000
    7.360000
    3.460000
    3.604000
    2.950000
    9.624000
    ];

reactive{6} = mean(reactive{5}); % Mean ATPC
reactive{7} = median(reactive{5}); % Median ATPC
reactive{8} = range(reactive{5}); % Range

reactive{9} = [ % Simulation times
    7.770188
    4.635420
    4.962202
    4.707025
    7.099807
    7.077286
    5.194617
    5.052334
    4.655389
    8.578722
    ];

reactive{10} = mean(reactive{9}); % Mean simulation time

reactive_delay{1} = [ % Reactive_delay GTT
    37
    60
    86
    39
    67
    81
    55
    36
    46
    70
    ];

reactive_delay{2} = mean(reactive_delay{1});
reactive_delay{3} = median(reactive_delay{1});
reactive_delay{4} = range(reactive_delay{1});

reactive_delay{5} = [ % Average Transmission Power Consumption (ATPC)
    1.120000
    1.792000
    2.312000
    9.480000e-01
    1.674000
    2.116000
    1.148000
    1.000000
    1.066000
    2.210000
    ];

reactive_delay{6} = mean(reactive_delay{5}); % Mean ATPC
reactive_delay{7} = median(reactive_delay{5}); % Median ATPC
reactive_delay{8} = range(reactive_delay{5}); % Range

reactive_delay{9} = [ % Simulation times
    4.017483
    4.615974
    5.018556
    3.979808
    4.608372
    4.923176
    4.159973
    4.115242
    3.985539
    5.003800
    ];

reactive_delay{10} = mean(reactive_delay{9}); % Mean simulation time

lmr{1} = [ % LMR GTT
    78
    98
    95
    89
    68
    82
    91
    76
    86
    65
    ];

lmr{2} = mean(lmr{1}); % Mean GTT
lmr{3} = median(lmr{1}); % Median GTT
lmr{4} = range(lmr{1}); % Range

lmr{5} = [ % Average Transmission Power Consumption (ATPC)
    2.104500
    2.879000
    2.746000
    2.501000
    1.964500
    2.661500
    2.787500
    1.780000
    2.615000
    1.808500
    ];

lmr{6} = mean(lmr{5}); % Mean ATPC
lmr{7} = median(lmr{5}); % Median ATPC
lmr{8} = range(lmr{5}); % Range

lmr{9} = [ % Simulation times
    5.441605
    5.775425
    5.689556
    5.399999
    5.460100
    5.729329
    5.797881
    5.861410
    8.892707
    7.594679
    ];

lmr{10} = mean(lmr{9}); % Mean simulation time

lmr{11} = [ % Packet Transmission Error Rate (PTER)
    1.632653
    8.000000e-01
    8.097166e-01
    9.259259e-01
    2.242152
    1.140684
    1.185771
    4.405286e-01
    3.333333e-01
    1.470588
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
    xlabel('Simulation Run')
    ylabel('Packet Transmission Error Rate (%)')
    str = sprintf('LMR Packet Transmission Error Rate, %d nodes per group, \n route discovery blocking period = 5 seconds, 10 simulation runs \n mean = %f%%',n,lmr{12});
    title(str);
    grid on
end
