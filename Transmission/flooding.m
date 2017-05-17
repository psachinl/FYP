clear

clear
close all

number_of_moving_groups = 3;
nodes_per_group = 2;
number_of_stationary_nodes = 3;
number_of_moving_nodes = number_of_moving_groups * nodes_per_group;
number_of_nodes = number_of_stationary_nodes + number_of_moving_nodes;
max_time = 400;
debug = true; % If true, text printed to console
plot_path = false; % If true, paths are plotted for each moving node

nodes{1,number_of_nodes} = []; % Cell array to store all nodes
edge_start_points = [1 3 3 2 6 1 7 4 7 8];
edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
edge_weights = [579 40 128 267 163 250 0 115 18 0];
start_node = [1,2,1,2]; % Array of start points for each group
end_node = [4,8,5,8]; % End points
min_speed=[1,1,1,1]; % Min and max speeds for each group
max_speed=[2,2,2,2];
map_node_positions = [340,440; 267,181; 340,919; 360,1000; 400,1000; 0,181; 0,18; 0,0];

% Set initial values for each stationary node 
for n = 1:number_of_stationary_nodes
    nodes{n} = StationaryNode;
    nodes{n}.id = n;
    nodes{n}.current_position = [map_node_positions(end_node(n),1),map_node_positions(end_node(n),2)];
end

% Station in bottom left of grid is closed
nodes{2}.message_to_transmit = true;
new_exit_point = 4;

% Set initial values for each moving node e.g. start point, end point etc.
for m = 1:number_of_moving_groups
    for n = 1:nodes_per_group
        index = n + (m-1)*nodes_per_group + number_of_stationary_nodes;
        
        nodes{index} = FloodingNode;
        nodes{index}.id = index;
        nodes{index}.group = m;
        nodes{index}.start_point = [map_node_positions(start_node(m),1),map_node_positions(start_node(m),2)];
        nodes{index}.end_point = [map_node_positions(end_node(m),1),map_node_positions(end_node(m),2)];
        nodes{index}.min_speed = min_speed(m);
        nodes{index}.max_speed = max_speed(m);
        nodes{index}.current_position = nodes{index}.start_point;
    end
end
clear m n k index

% Calculate path for each moving node
for node = 1+number_of_stationary_nodes:number_of_nodes
    [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,edge_weights,start_node(nodes{node}.group),end_node(nodes{node}.group),nodes{node}.min_speed,nodes{node}.max_speed,map_node_positions);
    overall_path = [start_and_end(1,:); main_path; start_and_end(end,:)];
    
    % Extend paths to avoid indexing errors
    while length(overall_path) < max_time
        overall_path(end+1,:) = overall_path(end,:);
    end
    
    nodes{node}.position = {start_and_end,waypoints,main_path,overall_path};
    
    clear start_and_end waypoints main_path overall_path
    
    if plot_path
        plotSPMBM(nodes{node}.position{1},nodes{node}.position{3},nodes{node}.position{2},node);
    end
end

clear node plot_path

% Loop over each time slice t
for t=1:max_time-1
    
    % Transmit message packets via flooding
    
    % Stationary node to moving node transmission step
    for src=1:number_of_stationary_nodes
        if nodes{src}.message_to_transmit
            for dest=1+number_of_stationary_nodes:number_of_nodes
                if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
%                     [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});
%                     
%                     if debug
%                         fprintf('Time = %d \n',t);
%                         fprintf('Node %d position changed after transmission from node %d \n',dest,src);
%                         fprintf('Node %d position{4} length = %d \n',dest,length(nodes{dest}.position{4}));
%                     end
                end
            end
        end
    end
    
    clear start_and_end waypoints main_path
    
    % Moving node to moving node transmission step
    for src=1+number_of_stationary_nodes:number_of_nodes
        if nodes{src}.message_to_transmit
            % TODO: Implement transmission via flooding for moving node to
            % moving node transmission
        end
    end

    clear src dest start_and_end start_and_end_w waypoints waypoints_w main_path main_path_w overall_path overall_path_w
    
    % Move nodes to next position in path    
    for n=1+number_of_stationary_nodes:number_of_nodes
        nodes{n}.current_position = [nodes{n}.position{4}(t+1,1),nodes{n}.position{4}(t+1,2)];
    end
    
end

clear t n k
