clear
close all

number_of_stationary_nodes = 3;
number_of_moving_nodes = 3;
number_of_nodes = number_of_stationary_nodes + number_of_moving_nodes;

nodes{1,number_of_nodes} = []; % Cell array to store all nodes
edge_start_points = [1 3 3 2 6 1 7 4 7 8];
edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
W = [579 40 128 267 163 250 0 115 18 0]; % Edge weights
start_node = [1,2,1]; % Array of start points for each node
end_node = [4,8,5]; % End points
plot_path = 0; % Whether to plot (1) the movement or not (0)
min_speed=[1,2,0.8]; % Min and max speeds for each node
max_speed=[2,3,1.4];
map_node_positions = [340,440; 267,181; 340,919; 360,1000; 400,1000; 0,181; 0,18; 0,0];

% Set initial values for each stationary node 
for n = 1:number_of_stationary_nodes
    nodes{n} = StationaryNode;
    nodes{n}.id = n;
    nodes{n}.current_position = [map_node_positions(end_node(n),1),map_node_positions(end_node(n),2)];
end

% Station in bottom left of grid is closed
nodes{2}.message_to_transmit = true;

% Set initial values for each moving node e.g. start point, end point etc.
for n = 1+number_of_stationary_nodes:number_of_nodes
    nodes{n} = DREAMNode;
    nodes{n}.id = n;
    nodes{n}.start_point = [map_node_positions(start_node(n-number_of_moving_nodes),1),map_node_positions(start_node(n-number_of_moving_nodes),2)];
    nodes{n}.end_point = [map_node_positions(end_node(n-number_of_moving_nodes),1),map_node_positions(end_node(n-number_of_moving_nodes),2)];
    nodes{n}.min_speed = min_speed(n-number_of_moving_nodes);
    nodes{n}.max_speed = max_speed(n-number_of_moving_nodes);
    nodes{n}.location_table{1,number_of_nodes} = [];
    nodes{n}.message_table{1,number_of_nodes} = [];
    nodes{n}.current_position = nodes{n}.start_point;
    
    % Positions of stationary nodes are fixed and therefore known at start
    for k=1:number_of_stationary_nodes
        nodes{n}.location_table{k} = nodes{k}.current_position;
    end
end

clear n k

% Initialise nodes

% Update packets contain new position and/or new message status values

for i=1+number_of_stationary_nodes:number_of_nodes
    for j=1+number_of_stationary_nodes:number_of_nodes
        if nodes{i}.checkBTRange(nodes{j}) && i~=j
            nodes{i}.location_table{j} = nodes{j}.current_position;
            nodes{i}.message_table{j} = nodes{j}.message_to_transmit;
            nodes{i}.table_updates = nodes{i}.table_updates + 1;
            nodes{j}.update_packets_transmitted = nodes{j}.update_packets_transmitted + 1;
        elseif i == j % Node updates it's own table entries, no need for packet transmission
            nodes{i}.location_table{i} = nodes{i}.current_position;
            nodes{i}.message_table{i} = nodes{i}.message_to_transmit;
            nodes{i}.table_updates = nodes{i}.table_updates + 1;
        end
    end
end

clear i j

% Calculate path for each moving node

for node = 1+number_of_stationary_nodes:number_of_nodes
    [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,W,start_node(node-number_of_moving_nodes),end_node(node-number_of_moving_nodes),nodes{node}.min_speed,nodes{node}.max_speed,map_node_positions);
    overall_path = [start_and_end(1,:); main_path; start_and_end(end,:)];
    nodes{node}.position = {start_and_end,waypoints,main_path,overall_path};
    
    clear start_and_end waypoints main_path overall_path
    
    if plot_path
        plotSPMBM(nodes{node}.position{1},nodes{node}.position{3},nodes{node}.position{2},node);
    end
end

clear node

% Loop over each time slice t
for t=1:length(nodes{5}.position{4})-4 % TODO: change limit to run for all time slices - may need to extend some paths
    
    % Transmit message packets

    % Transmission occurs if a given node has a message to transmit, if the
    % destination node is within BLE range and if the destination node has not
    % received the message already. If the destination node already has the
    % message, the message tables are updated by the destination node sending
    % an update packet to the source node
    
    % Stationary node to moving node transmission step
    for src=1:number_of_stationary_nodes
        if nodes{src}.message_to_transmit
            for dest=1+number_of_stationary_nodes:number_of_nodes
                if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                    [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                    
                    % Recalculate path to new exit point
                    remaining_positions = [nodes{dest}.position{4}(t:end,1),nodes{dest}.position{4}(t:end,2)];
%                     old_positions = nodes{dest}.position;
                    [start_and_end,waypoints,main_path] = recalculate(edge_start_points,edge_end_points,W,end_node(dest-number_of_moving_nodes),end_node(1),nodes{dest}.min_speed,nodes{dest}.max_speed,map_node_positions,remaining_positions);
                    overall_path = [start_and_end(1,:); main_path; start_and_end(end,:)];
                    nodes{dest}.position = {start_and_end,waypoints,main_path,overall_path};
                end
            end
        end
    end
    
    % Moving node to moving node transmission step
    for src=1+number_of_stationary_nodes:number_of_nodes
        if nodes{src}.message_to_transmit
            for dest=1+number_of_stationary_nodes:number_of_nodes
                if dest ~= src
                    if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                        [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                    elseif nodes{src}.checkBTRange(nodes{dest}) && nodes{dest}.message_to_transmit
                        nodes{src}.message_table{dest} = true;
                        nodes{src}.table_updates = nodes{src}.table_updates + 1;
                        nodes{dest}.update_packets_transmitted = nodes{dest}.update_packets_transmitted + 1;
                    end
                    % TODO: If a message has been received, recalculate
                    % path if the end point is the closed exit point
                end
            end
        end
    end

    clear src dest
    
    % Move nodes to next position in path and update tables
    
    for n=1+number_of_stationary_nodes:number_of_nodes
        % Move node to next position and update location table
        nodes{n}.current_position = [nodes{n}.position{4}(t+1,1),nodes{n}.position{4}(t+1,2)];
        nodes{n}.location_table{n} = nodes{n}.current_position;
        nodes{n}.table_updates = nodes{n}.table_updates + 1;
        
        % Send update packets to nearby nodes to update their location
        % tables
        for k=1+number_of_stationary_nodes:number_of_nodes
            if k ~= n && nodes{n}.checkBTRange(nodes{k})
                nodes{n}.update_packets_transmitted = nodes{n}.update_packets_transmitted + 1;
                nodes{k}.location_table{n} = nodes{n}.current_position;
                nodes{k}.table_updates = nodes{k}.table_updates + 1;
            end
        end
    end
    
end

clear t n k

% TODO: Add ack packets if required to model link failure
