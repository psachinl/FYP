clear
close all

number_of_moving_groups = 3;
nodes_per_group = 2;
number_of_stationary_nodes = 3;
number_of_moving_nodes = number_of_moving_groups * nodes_per_group;
number_of_nodes = number_of_stationary_nodes + number_of_moving_nodes;
max_time = 400;
debug = true; % If true, text printed to console
plot_path = false; % If true, initial node paths are plotted

% If result flag is true, final result is printed to console
print_timing_result = true;
print_power_result = false;

nodes{1,number_of_nodes} = []; % Cell array to store all nodes
edge_start_points = [1 3 3 2 6 1 7 4 7 8];
edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
edge_weights = [579 40 128 267 163 250 0 115 18 0];
start_node = [1,2,1,2]; % Array of start points for each group
end_node = [4,8,5,8]; % End points
min_speed=[1,2,0.8,2.5]; % Min and max speeds for each group
max_speed=[2,3,1.4,2.5];
map_node_positions = [340,440; 267,181; 340,919; 360,1000; 400,1000; 0,181; 0,18; 0,0];

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

% Set initial values for each moving node e.g. start point, end point etc.
for m = 1:number_of_moving_groups
    for n = 1:nodes_per_group
        index = n + (m-1)*nodes_per_group + number_of_stationary_nodes;
        
        nodes{index} = ReactiveNode;
        nodes{index}.id = index;
        nodes{index}.group = m;
        nodes{index}.start_point = [map_node_positions(start_node(m),1),map_node_positions(start_node(m),2)];
        nodes{index}.end_point = [map_node_positions(end_node(m),1),map_node_positions(end_node(m),2)];
        nodes{index}.min_speed = min_speed(m);
        nodes{index}.max_speed = max_speed(m);
        nodes{index}.current_position = nodes{index}.start_point;
    end
end
clear m n index

% Calculate path for each moving node

nodes = calculatePaths(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,start_node,end_node,map_node_positions,max_time,plot_path);

clear node plot_path

% Loop over each time slice t
for t=1:max_time-1
    
    % Transmit message packets

    % The reactive routing algorithm floods the channel with route request
    % packets. Once a route has been discovered, the message is
    % transmitted. This simulation will assume only 1 discover and transmit
    % cycle can be done in 1s.
    
    % Stationary node to moving node transmission step
    nodes = stationary2MovingTransmission(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,end_node,new_exit_point,map_node_positions,debug,t);
    
    clear start_and_end waypoints main_path
    
    % Moving node to moving node transmission step
    for src=1+number_of_stationary_nodes:number_of_nodes
        if nodes{src}.message_to_transmit
            % Source node broadcasts route request packets         
            [nodes{src},~,~] = nodes{src}.broadcast;
            % TODO: Implement some sort of delay to prevent
            % broadcasting every second although that can be a new
            % algorithm

            % Check if any nodes are within BLE range
            in_range = getNodesInRange(nodes{src}.id,nodes,number_of_stationary_nodes,number_of_nodes);

            % Send replies if nodes are within BLE range
            if ~isempty(in_range)
                % Vector will always update since only nodes without the
                % message are returned
                
                for i=1:min(nodes{src}.transmissions_per_second,length(in_range))
                    dest = in_range(i); 

                    % Send reply to broadcasting node and update tables
                    [nodes{dest},nodes{src}] = nodes{dest}.sendReply(nodes{src});

                    % Transmit from src to dest
                    
                    if debug
                        fprintf('Time = %d \n',t);
                        fprintf('Transmitting from node %d to %d \n',src,dest);
                        fprintf('Node %d position = [%d,%d] \n',src,nodes{src}.current_position(1),nodes{src}.current_position(2));
                        fprintf('Node %d position = [%d,%d] \n',dest,nodes{dest}.current_position(1),nodes{dest}.current_position(2));
                    end
                    
                    [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});

                    % Update paths for destination node
                    nodes{dest} = updatePaths(nodes{dest},map_node_positions,edge_start_points,edge_end_points,edge_weights,new_exit_point,t);
                end
            end          
        end
    end

    clear src dest start_and_end start_and_end_w waypoints waypoints_w main_path main_path_w overall_path overall_path_w i
    
    % Move nodes to next position in path
    
    for n=1+number_of_stationary_nodes:number_of_nodes
        % Move node to next position
        nodes{n}.current_position = [nodes{n}.position{4}(t+1,1),nodes{n}.position{4}(t+1,2)];
    end
    [first_transmission_time,last_transmission_time] = storeTransmissionTimes(nodes,test_group,number_of_stationary_nodes,nodes_per_group,first_transmission_time,last_transmission_time,t);
end

clear t n k

[group_transmission_time,group_power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time);
