clear
close all

number_of_nodes = 3;
nodes{1,number_of_nodes} = []; % Cell array to store all nodes
grid_size = 10;
% positions = randi(grid_size,number_of_nodes,2);
% load positions

edge_start_points = [1 3 3 2 6 1 7 4 7 8];
edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
W = [579 40 128 267 163 250 0 115 18 0]; % Edge weights
start_node = [1,2,1]; % Array of start points for each node
end_node = [4,8,5]; % End points
plot_path = 1; % Whether to plot (1) the movement or not (0)
min_speed=[1,2,0.8]; % Min and max speeds for each node
max_speed=[2,3,1.4];
map_node_positions = [340,440; 267,181; 340,919; 360,1000; 400,1000; 0,181; 0,18; 0,0];

% Create cell array to store the movement of multiple nodes
node_positions = {};

for n = 1:number_of_nodes
    nodes{n} = DREAMNode;
    nodes{n}.id = n;
    nodes{n}.start_point = [map_node_positions(start_node(n),1),map_node_positions(start_node(n),2)];
    nodes{n}.end_point = [map_node_positions(end_node(n),1),map_node_positions(end_node(n),2)];
    nodes{n}.location_table{1,number_of_nodes} = [];
    nodes{n}.message_table{1,number_of_nodes} = [];
    nodes{n}.position{1} = nodes{n}.start_point;
    
    if ~mod(n,5) % Seed message to every 5th node 
        nodes{n}.message_to_transmit = true;
    end
end

clear n

figure
hold on
for n=1:number_of_nodes
    plot(nodes{n}.position{1}(1),nodes{n}.position{1}(2),'*')
end
hold off
grid on

clear n

% Fill location tables

% Update packets contain new position and/or new message status values
% TODO: If the node has moved, transmit update messages to neighbouring
% nodes
% 
for i=1:number_of_nodes
    for j=1:number_of_nodes
        if nodes{i}.checkBTRange(nodes{j})
            nodes{i}.location_table{j} = nodes{j}.position;
            nodes{i}.message_table{j} = nodes{j}.message_to_transmit;
            nodes{i}.table_updates = nodes{i}.table_updates + 1;
            nodes{j}.update_packets_transmitted = nodes{j}.update_packets_transmitted + 1;
        end
    end
end

clear i j

% Transmit message packets

% Transmission occurs if a given node has a message to transmit, if the
% destination node is within BLE range and if the destination node has not
% received the message already. If the destination node already has the
% message, the message tables are updated by the destination node sending
% an update packet to the source node

for src=1:number_of_nodes
    if nodes{src}.message_to_transmit
        for dest=1:number_of_nodes
            if dest ~= src
                if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                    [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                elseif nodes{src}.checkBTRange(nodes{dest}) && nodes{dest}.message_to_transmit
                    nodes{src}.message_table{dest} = true;
                    nodes{src}.table_updates = nodes{src}.table_updates + 1;
                    nodes{dest}.update_packets_transmitted = nodes{dest}.update_packets_transmitted + 1;
                end
            end
        end
    end
end

clear src dest

% Calculate path for each node

for node = 1:number_of_nodes
    [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,W,start_node(node),end_node(node),min_speed(node),max_speed(node),map_node_positions,plot_path);    
    nodes{node}.position = {start_and_end,waypoints,main_path};
    
    if plot_path
        plotSPMBM(nodes{node}.position{1},nodes{node}.position{3},nodes{node}.position{2},node);
    end
end

% Get position of nodes at time t = 10 and measure distance between them

pos_check_nodes = [1,2,3];
time_pos=zeros([length(pos_check_nodes) 2]);
time = 10;

for node = pos_check_nodes
    p = getTimePosition(nodes{node}.position,time);
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
    
% TODO: Add ack packets if required
