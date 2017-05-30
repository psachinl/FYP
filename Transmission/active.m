clear
close all
tic;

% Get simulation parameters
params = getSimulationParams;
number_of_moving_groups = params{1};
nodes_per_group = params{2};
number_of_stationary_nodes = params{3};
edge_start_points = params{4};
edge_end_points = params{5};
edge_weights = params{6};
start_node = params{7};
end_node = params{8};
min_speed = params{9};
max_speed = params{10};
map_node_positions = params{11};
max_time = params{12};
debug = params{13};
plot_path = params{14};
print_timing_result = params{15};
print_power_result = params{16};
quit_simulation_early = params{17};

number_of_moving_nodes = number_of_moving_groups * nodes_per_group;
number_of_nodes = number_of_stationary_nodes + number_of_moving_nodes;

nodes{1,number_of_nodes} = []; % Cell array to store all nodes

% Set initial values for each stationary node
stationary_group = 0;
for n = 1:number_of_stationary_nodes
    nodes{n} = StationaryNode;
    nodes{n} = nodes{n}.initialise(n,stationary_group,map_node_positions,end_node);
end

% Station in bottom left of grid is closed
nodes{2}.message_to_transmit = true;
new_exit_point = 4;
test_group = 2; % Group 2 is moving towards the closed station
first_transmission_time = -1; % Initialise to -1 for error handling
last_transmission_time = -1;
initial_power_consumption = -1;
final_power_consumption = -1;
overall_power_consumption = -1;

% Set initial values for each moving node e.g. start point, end point etc.
for m = 1:number_of_moving_groups
    for n = 1:nodes_per_group
        index = n + (m-1)*nodes_per_group + number_of_stationary_nodes;
        
        nodes{index} = DREAMNode;
        nodes{index}.id = index;
        nodes{index}.group = m;
        nodes{index}.start_point = [map_node_positions(start_node(m),1),map_node_positions(start_node(m),2)];
        nodes{index}.end_point = [map_node_positions(end_node(m),1),map_node_positions(end_node(m),2)];
        nodes{index}.min_speed = min_speed(m);
        nodes{index}.max_speed = max_speed(m);
        nodes{index}.location_table{1,number_of_nodes} = [];
        nodes{index}.message_table{1,number_of_nodes} = [];
        nodes{index}.current_position = nodes{index}.start_point;

        % Positions of stationary nodes are fixed and therefore known at start
        for k=1:number_of_stationary_nodes
            nodes{index}.location_table{k} = nodes{k}.current_position;
        end
    end
end
clear m n k index

% Initialise nodes

% Update packets contain new position and/or new message status values

for i=1+number_of_stationary_nodes:number_of_nodes
    for j=1+number_of_stationary_nodes:number_of_nodes
        if nodes{i}.checkBTRange(nodes{j}) && i~=j
            nodes{i}.location_table{j} = nodes{j}.current_position;
            nodes{i}.message_table{j} = nodes{j}.message_to_transmit;
            nodes{i}.table_updates = nodes{i}.table_updates + 1;
            nodes{j}.update_packets_transmitted = nodes{j}.update_packets_transmitted + 1;
        elseif i == j % Node updates its own table entries, no need for packet transmission
            nodes{i}.location_table{i} = nodes{i}.current_position;
            nodes{i}.message_table{i} = nodes{i}.message_to_transmit;
            nodes{i}.table_updates = nodes{i}.table_updates + 1;
        end
    end
end

clear i j

% Calculate path for each moving node

nodes = calculatePaths(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,start_node,end_node,map_node_positions,max_time,plot_path);

clear node plot_path

% Loop over each time slice t
for t=1:max_time-1
    
    % Transmit message packets

    % Transmission occurs if a given node has a message to transmit, if the
    % destination node is within BLE range and if the destination node has not
    % received the message already. If the destination node already has the
    % message, the message tables are updated by the destination node sending
    % an update packet to the source node
    
    % Stationary node to moving node transmission step
    nodes = stationary2MovingTransmission(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,end_node,new_exit_point,map_node_positions,debug,t);
    
    clear start_and_end waypoints main_path
    
    % Moving node to moving node transmission step
    for src=1+number_of_stationary_nodes:number_of_nodes
        nodes{src}.packets_transmitted_slice = 0;
        if nodes{src}.message_to_transmit
            for dest=1+number_of_stationary_nodes:number_of_nodes
                if dest ~= src && nodes{src}.packets_transmitted_slice < nodes{src}.max_transmissions_per_sec
                    if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                        if debug
                            fprintf('Time = %d \n',t);
                            fprintf('Transmitting from node %d to %d \n',src,dest);
                            fprintf('Node %d position = [%d,%d] \n',src,nodes{src}.current_position(1),nodes{src}.current_position(2));
                            fprintf('Node %d position = [%d,%d] \n',dest,nodes{dest}.current_position(1),nodes{dest}.current_position(2));
                        end
                        
                        % Transmit message to destination node
                        [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                        % Increment counter for number of packets
                        % transmitted in the current time slice
                        nodes{src}.packets_transmitted_slice = nodes{src}.packets_transmitted_slice + 1;
                        
                        % Update paths for destination node
                        nodes{dest} = updatePaths(nodes{dest},map_node_positions,edge_start_points,edge_end_points,edge_weights,new_exit_point,t);

                    elseif nodes{src}.checkBTRange(nodes{dest}) && nodes{dest}.message_to_transmit
                        nodes{src}.message_table{dest} = true;
                        nodes{src}.table_updates = nodes{src}.table_updates + 1;
                        nodes{dest}.update_packets_transmitted = nodes{dest}.update_packets_transmitted + 1;
                    end
                end
            end
        end
    end

    clear src dest start_and_end start_and_end_w waypoints waypoints_w main_path main_path_w overall_path overall_path_w
    
    % Move nodes to next position in path and update tables
    
    for n=1+number_of_stationary_nodes:number_of_nodes
        % Move node to next position and update location table
        nodes{n}.old_pos = nodes{n}.current_position; % Store old position
        nodes{n}.current_position = [nodes{n}.position{4}(t+1,1),nodes{n}.position{4}(t+1,2)];
        nodes{n}.location_table{n} = nodes{n}.current_position;
        nodes{n}.table_updates = nodes{n}.table_updates + 1;
        
        % Send update packets to nearby nodes to update their location
        % tables but only if the node has moved from its previous position
        for k=1+number_of_stationary_nodes:number_of_nodes
            if k ~= n && nodes{n}.checkBTRange(nodes{k}) && ~isequal(nodes{n}.current_position,nodes{n}.old_pos)
                nodes{n}.update_packets_transmitted = nodes{n}.update_packets_transmitted + 1;
                nodes{k}.location_table{n} = nodes{n}.current_position;
                nodes{k}.table_updates = nodes{k}.table_updates + 1;
            end
        end
    end
    [first_transmission_time,last_transmission_time] = storeTransmissionTimes(nodes,test_group,number_of_stationary_nodes,nodes_per_group,first_transmission_time,last_transmission_time,t);
    [initial_power_consumption,final_power_consumption] = calculatePowerConsumption(nodes,test_group,number_of_stationary_nodes,nodes_per_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption);
    
    if last_transmission_time > 0 && quit_simulation_early
        fprintf('Ending simulation early, time = %d \n',t);
        [group_transmission_time,power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption,overall_power_consumption,nodes_per_group);
        toc;
        return
    end
end

clear t n k

overall_power_consumption = calculateOverallPowerConsumption(nodes,number_of_stationary_nodes,test_group,nodes_per_group);
[group_transmission_time,power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption,overall_power_consumption,nodes_per_group);
toc;
