clear
close all

% 20 nodes per group results

n = 20;
plot_figs = true;

active={};
reactive={};
reactive_delay={};
lmr={};

active{1} = [ % Active GTT
    123
    98
    135
    121
    121
    94
    123
    133
    96
    136
    ];

% mean_active_GTT = mean(active_GTT);
% median_active_GTT = median(active_GTT);
% range_active_GTT = range(active_GTT);
active{2} = mean(active{1}); % Mean GTT
active{3} = median(active{1}); % Median GTT
active{4} = range(active{1}); % Range of GTT values

active_ATPC = [
    2.632750e+02
    3.071625e+02
    4.829875e+02
    3.946250e+02
    2.660375e+02
    2.441875e+02
    2.547625e+02
    2.751875e+02
    2.276250e+02
    3.656750e+02
    ];

mean_active_ATPC = mean(active_ATPC);
median_active_ATPC = median(active_ATPC);
range_active_ATPC = range(active_ATPC);

reactive_GTT = [
    114
    127
    112
    146
    119
    109
    124
    105
    121
    95
    ];

mean_reactive_GTT = mean(reactive_GTT);
median_reactive_GTT = median(reactive_GTT);
range_reactive_GTT = range(reactive_GTT);

reactive_delay_GTT = [
    127
    123
    120
    127
    107
    131
    117
    128
    133
    128
    ];

mean_reactive_delay_GTT = mean(reactive_delay_GTT);
median_reactive_delay_GTT = median(reactive_delay_GTT);
range_reactive_delay_GTT = range(reactive_delay_GTT);

lmr_GTT = [
    132
    88
    122
    139
    121
    109
    155
    144
    166
    137
    ];

mean_lmr_GTT = mean(lmr_GTT);
median_lmr_GTT = median(lmr_GTT);
range_lmr_GTT = range(lmr_GTT);

if plot_figs
    figure(1)
    hold on
    plot(active{1},'x')
    plot(reactive_GTT,'o')
    plot(reactive_delay_GTT,'*')
    plot(lmr_GTT,'.')
    xlabel('Simulation Run')
    ylabel('Group Transmission Time (s)')
%     ylim([0 200])
    legend('DREAM', 'Reactive', 'Reactive Delay', 'LMR', 'Location', 'best')
    str = sprintf('Group Transmission Time, %d nodes per group',n);
    title(str);
end
