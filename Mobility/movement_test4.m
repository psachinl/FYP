clear

% edge_start_points = [6 1 2 2 3 4 4 5 5 6];
% edge_end_points =   [2 6 3 5 4 1 6 3 4 3];
% W = [41 99 51 32 15 45 38 32 36 29];
% edge_start_points = [2 3 4 5 6 5 1 4];
% edge_end_points =   [3 4 1 4 3 6 2 6];
% W = [51 15 45 36 29 15 25 43];
edge_start_points = [1 3 3 2 6 1 7 4 7 8];
edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
W = [579 40 128 267 163 250 0 115 18 0];
start_node = [1,2,1]; % Array of start points for each node
end_node = [4,8,5]; % End points
plot_path = 1; % Whether to plot (1) the movement or not (0)
number_of_nodes = 3;
min_speed=[1,2,0.8]; % Min and max speeds for each node
max_speed=[2,3,1.4];
map_node_positions = [340,440; 267,181; 340,919; 360,1000; 400,1000; 0,181; 0,18; 0,0];

% Create cell array to store the movement of multiple nodes
node_positions = {};

for node = 1:number_of_nodes
    [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,W,start_node(node),end_node(node),min_speed(node),max_speed(node),map_node_positions,plot_path);
    node_positions{node,1} = start_and_end;
    node_positions{node,2} = waypoints;
    node_positions{node,3} = main_path;
    
    if plot_path == 1
        plotSPMBM(node_positions{node,1},node_positions{node,3},node_positions{node,2},node);
    end
end

% Get position of nodes at time t = 100 and measure distance between them

pos_check_nodes = [1,2,3];
time_pos=zeros([length(pos_check_nodes) 2]);
time = 100;

for node = pos_check_nodes
    p = getTimePosition(node_positions(node,:),time);
    time_pos(node,1) = p(1);
    time_pos(node,2) = p(2);
end

% For demo purposes
figure
hold on
grid on
for node = pos_check_nodes
    plot(time_pos(node,1),time_pos(node,2),'x')
end
hold off
xlim([0 1000])
ylim([0 1000])
xlabel('X-axis coordinate')
ylabel('Y-axis coordinate')
title(['Shortest Path Map Based Movement Mobility Model - t = ' num2str(time)])
legend('Node 1', 'Node 2', 'Node 3', 'Location', 'best')

in_range = checkBTRange(time_pos(pos_check_nodes(1),:),time_pos(pos_check_nodes(2),:))
in_range2 = checkBTRange(time_pos(pos_check_nodes(1),:),time_pos(pos_check_nodes(3),:))

if in_range == true
    % Transmit message
    % TODO: Implement algorithm
else
    % Do nothing since not in transmission range
end
