clear
close all

% 50 nodes per group results

n = 50;
plot_figs = false;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    64
    90
    63
    48
    99
    40
    79
    77
    70
    60
    ];

active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active{5} = [ % Average Transmission Power Consumption (ATPC)
    3.915400e+01
    7.412450e+01
    4.139850e+01
    3.570150e+01
    7.069650e+01
    1.789300e+01
    4.457650e+01
    5.177600e+01
    3.625850e+01
    3.655200e+01
    ];

active{6} = mean(active{5}); % Mean ATPC
active{7} = median(active{5}); % Median ATPC
active{8} = range(active{5}); % Range

active{9} = [ % Simulation times
    49.707302
    47.964172
    41.768990
    39.284946
    46.640784
    33.318341
    37.741494
    39.278432
    35.426104
    37.391266
    ];

active{10} = mean(active{9}); % Mean simulation time

reactive{1} = [ % Reactive GTT
    101
    77
    90
    75
    62
    83
    74
    65
    73
    86
    ];

reactive{2} = mean(reactive{1});
reactive{3} = median(reactive{1}); 
reactive{4} = range(reactive{1});

reactive{5} = [ % Average Transmission Power Consumption (ATPC)
    1.107600e+01
    8.144000
    1.078000e+01
    7.800000
    9.092000
    1.056000e+01
    1.081200e+01
    9.464000
    8.972000
    8.120000
    ];

reactive{6} = mean(reactive{5}); % Mean ATPC
reactive{7} = median(reactive{5}); % Median ATPC
reactive{8} = range(reactive{5}); % Range

reactive{9} = [ % Simulation times
    4.577703
    4.073823
    4.249365
    3.913116
    4.028293
    4.239896
    4.237614
    4.043596
    4.001844
    3.805857
    ];

reactive{10} = mean(reactive{9}); % Mean simulation time

reactive_delay{1} = [ % Reactive_delay GTT
    123
    92
    107
    103
    110
    103
    78
    104
    81
    128
    ];

reactive_delay{2} = mean(reactive_delay{1});
reactive_delay{3} = median(reactive_delay{1});
reactive_delay{4} = range(reactive_delay{1});

reactive_delay{5} = [ % Average Transmission Power Consumption (ATPC)
    2.844000
    2.280000
    2.724000
    2.372000
    2.484000
    2.324000
    1.980000
    2.512000
    2.012000
    3.016000
    ];

reactive_delay{6} = mean(reactive_delay{5}); % Mean ATPC
reactive_delay{7} = median(reactive_delay{5}); % Median ATPC
reactive_delay{8} = range(reactive_delay{5}); % Range

reactive_delay{9} = [ % Simulation times
    3.721035
    3.507832
    3.698771
    3.571333
    3.563639
    3.471340
    3.326845
    3.546080
    3.381952
    3.801016
    ];

reactive_delay{10} = mean(reactive_delay{9}); % Mean simulation time

lmr{1} = [ % LMR GTT
    141
    94
    78
    128
    91
    78
    121
    102
    139
    101
    ];

lmr{2} = mean(lmr{1}); % Mean GTT
lmr{3} = median(lmr{1}); % Median GTT
lmr{4} = range(lmr{1}); % Range

lmr{5} = [ % Average Transmission Power Consumption (ATPC)
    2.579000
    2.652000
    2.122000
    2.904000
    2.920000
    2.256000
    2.798000
    2.316000
    3.357000
    2.612000
    ];

lmr{6} = mean(lmr{5}); % Mean ATPC
lmr{7} = median(lmr{5}); % Median ATPC
lmr{8} = range(lmr{5}); % Range

lmr{9} = [ % Simulation times
    3.942953
    3.690658
    3.378878
    3.724846
    3.525159
    3.327736
    3.757192
    3.609031
    3.850186
    3.501413
    ];

lmr{10} = mean(lmr{9}); % Mean simulation time

lmr{11} = [ % Packet Transmission Error Rate (PTER)
    1.25
    0
    1.282051
    2.352941
    0
    6.493506
    2.597403
    0
    3.750000
    0
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
