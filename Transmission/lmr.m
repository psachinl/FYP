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
print_packet_error_rate = true; % LMR specific parameter

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
        
        nodes{index} = LMRNode;
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
    % packets. Once routes have been discovered, transmission can occur.
    % For moving node to moving node transmission, route discovery periods
    % have a blocking period between them so invalid routes may be present
    % in the route cache at certain times in the simulation.
    
    % Stationary node to moving node transmission step
    nodes = stationary2MovingTransmission(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,end_node,new_exit_point,map_node_positions,debug,t);
    
    clear start_and_end waypoints main_path
    
    % Moving node to moving node transmission step
    for src=1+number_of_stationary_nodes:number_of_nodes
        nodes{src}.packets_transmitted_slice = 0;
        if nodes{src}.message_to_transmit
            if isempty(nodes{src}.route_cache)
                if ~nodes{src}.checkRouteRequestBlocked(t)
                    % Source node broadcasts route request packets to determine
                    % new routes if the route cache is empty and the node is
                    % not within the blocking period for transmitting route
                    % request packets
                    [nodes{src},~,~] = nodes{src}.broadcast(t);

                    % Check if any nodes are within BLE range
                    nodes{src}.route_cache = getNodesInRange(nodes{src}.id,nodes,number_of_stationary_nodes,number_of_nodes);

                    % Send replies if nodes are within BLE range
                    if ~isempty(nodes{src}.route_cache)
                        % Vector will always update since only nodes without the
                        % message are returned (or will be empty)

                        for i=1:length(nodes{src}.route_cache)
                            dest = nodes{src}.route_cache(i);

                            % Send reply to broadcasting node and update tables
                            [nodes{dest},nodes{src}] = nodes{dest}.sendReply(nodes{src});
                        end
                    end
                end
            else % Route cache not empty
                % Transmit to nodes where routes are present in the route cache
                remaining_routes = nodes{src}.route_cache;
                for dest=nodes{src}.route_cache
                    if checkBTRange(nodes{src},nodes{dest}) && nodes{src}.packets_transmitted_slice < nodes{src}.max_transmissions_per_sec
                        % If route is still valid and the node has not hit 
                        % the transmissions per second limit, transmit
                        if debug
                            fprintf('Time = %d \n',t);
                            fprintf('Transmitting from node %d to %d \n',src,dest);
                            fprintf('Node %d position = [%d,%d] \n',src,nodes{src}.current_position(1),nodes{src}.current_position(2));
                            fprintf('Node %d position = [%d,%d] \n',dest,nodes{dest}.current_position(1),nodes{dest}.current_position(2));
                        end
                    
                        [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
                        % Increment packets transmitted in the current time
                        % slice
                        nodes{src}.packets_transmitted_slice = nodes{src}.packets_transmitted_slice + 1;

                        % Update paths for destination node
                        nodes{dest} = updatePaths(nodes{dest},map_node_positions,edge_start_points,edge_end_points,edge_weights,new_exit_point,t);
                    elseif nodes{src}.packets_transmitted_slice >= nodes{src}.max_transmissions_per_sec
                        % Transmission limit reached, do nothing
                        if debug
                            fprintf('Transmission limit reached for time slice \n')
                        end
                    else
                        % If the route is no longer valid, transmission
                        % fails
                        nodes{src}.failed_transmissions = nodes{src}.failed_transmissions + 1;
                    end
                    % Remove routes from route cache once transmission has
                    % been attempted to that node
                    remaining_routes = remaining_routes(remaining_routes~=dest);
                end
                % Only keep the remaining (unused) routes in the cache for 
                % transmission in the next time slice
                nodes{src}.route_cache = remaining_routes;
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
    [initial_power_consumption,final_power_consumption] = calculatePowerConsumption(nodes,test_group,number_of_stationary_nodes,nodes_per_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption);
    
    if last_transmission_time > 0 && quit_simulation_early
        fprintf('Ending simulation early, time = %d \n',t);
        packet_error_rate = calculatePacketErrorRate(nodes,test_group,number_of_stationary_nodes,nodes_per_group,print_packet_error_rate);
        [group_transmission_time,power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption,overall_power_consumption,nodes_per_group);
        toc;
        return
    end
end

clear t n k

overall_power_consumption = calculateOverallPowerConsumption(nodes,number_of_stationary_nodes,test_group,nodes_per_group);
packet_error_rate = calculatePacketErrorRate(nodes,test_group,number_of_stationary_nodes,nodes_per_group,print_packet_error_rate);
[group_transmission_time,power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption,overall_power_consumption,nodes_per_group);
toc;
