function plotSPMBM(start_and_end,main_path,waypoints,node)

if ~exist('node','var')
     % third parameter does not exist, so default it to something
      node = 1;
end

figure
hold on
grid on
plot(start_and_end(1,1),start_and_end(1,2),'^')
plot(start_and_end(2,1),start_and_end(2,2),'o')
plot(main_path(:,1),main_path(:,2),'.')
plot(waypoints(:,1),waypoints(:,2),'mx')
% plot(map_node_positions(:,1),map_node_positions(:,2),'mx')
xlim([0 1000])
ylim([0 1000])
hold off
xlabel('X-axis coordinate')
ylabel('Y-axis coordinate')
title(['Shortest Path Map Based Movement Mobility Model - Node ' num2str(node)])
legend('Start Position', 'End Position', 'Node Path', 'Waypoint', 'Location', 'best')
