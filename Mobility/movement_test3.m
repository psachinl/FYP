clear

% edge_start_points = [6 1 2 2 3 4 4 5 5 6];
% edge_end_points =   [2 6 3 5 4 1 6 3 4 3];
% W = [41 99 51 32 15 45 38 32 36 29];
edge_start_points = [2 3 4 5 6 5 1 4];
edge_end_points =   [3 4 1 4 3 6 2 6];
W = [51 15 45 36 29 15 25 43];
start_node = 1;
end_node = 6;
start_node2 = 2;
end_node2 = 5;

min_speed=1;
max_speed=2;
map_node_positions = [80,0; 80,90; 30,30; 80,40; 70,30; 20,80; 0,0];

path = getPath(edge_start_points,edge_end_points,W,start_node,end_node);
[start_and_end,waypoints,main_path] = getMovement(path,min_speed,max_speed,map_node_positions);

figure
hold on
grid on
plot(start_and_end(1,1),start_and_end(1,2),'^')
plot(start_and_end(2,1),start_and_end(2,2),'o')
plot(main_path(:,1),main_path(:,2),'.')
plot(waypoints(:,1),waypoints(:,2),'mx')
% plot(map_node_positions(:,1),map_node_positions(:,2),'mx')
xlim([0 100])
ylim([0 100])
hold off
xlabel('X-axis coordinate')
ylabel('Y-axis coordinate')
title('Shortest Path Map Based Movement Mobility Model')
legend('Start Position', 'End Position', 'Node Path', 'Waypoint', 'Location', 'best')

path2 = getPath(edge_start_points,edge_end_points,W,start_node2,end_node2);
[start_and_end2,waypoints2,main_path2] = getMovement(path2,min_speed,max_speed,map_node_positions);

figure
hold on
grid on
plot(start_and_end2(1,1),start_and_end2(1,2),'^')
plot(start_and_end2(2,1),start_and_end2(2,2),'o')
plot(main_path2(:,1),main_path2(:,2),'.')
plot(waypoints2(:,1),waypoints2(:,2),'mx')
% plot(map_node_positions(:,1),map_node_positions(:,2),'mx')
xlim([0 100])
ylim([0 100])
hold off
xlabel('X-axis coordinate')
ylabel('Y-axis coordinate')
title('Shortest Path Map Based Movement Mobility Model')
legend('Start Position', 'End Position', 'Node Path', 'Waypoint', 'Location', 'best')
