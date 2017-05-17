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

nodes{1,number_of_nodes} = []; % Cell array to store all nodes
edge_start_points = [1 3 3 2 6 1 7 4 7 8];
edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
edge_weights = [579 40 128 267 163 250 0 115 18 0];
start_node = [1,2,1,2]; % Array of start points for each group
end_node = [4,8,5,8]; % End points
plot_path = 0; % Whether to plot (1) the movement or not (0)
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
