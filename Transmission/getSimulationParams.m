function params = getSimulationParams
    % Function that returns simulation parameters
    
    % Node parameters
    number_of_moving_groups = 3;
    nodes_per_group = 20;
    number_of_stationary_nodes = 3;
    
    % Graph parameters
    edge_start_points = [1 3 3 2 6 1 7 4 7 8];
    edge_end_points =   [3 4 5 6 7 2 6 5 8 7];
    edge_weights = [579 40 128 267 163 250 0 115 18 0];
    start_node = [1,2,1,2]; % Array of start points for each group
    end_node = [4,8,5,8]; % End points
    min_speed=[1,2,0.8,2.5]; % Min and max speeds for each group
    max_speed=[2,3,1.4,2.5];
    map_node_positions = [340,440; 267,181; 340,919; 360,1000; 400,1000; 0,181; 0,18; 0,0];

    % Max simulation time
    max_time = 300;
    
    % Debugging flags
    debug = false; % If true, text printed to console
    plot_path = false; % If true, initial node paths are plotted
    
    % If result flag is true, final result is printed to console
    print_timing_result = true;
    print_power_result = true;
    
    % If quit flag is true, the simulation will exit once all nodes in the test
    % group have recieved the message
    quit_simulation_early = true;
    
    params = {number_of_moving_groups,nodes_per_group,number_of_stationary_nodes,edge_start_points,edge_end_points,edge_weights,start_node,end_node,min_speed,max_speed,map_node_positions,max_time,debug,plot_path,print_timing_result,print_power_result,quit_simulation_early};
end
