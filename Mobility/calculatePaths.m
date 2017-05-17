function nodes = calculatePaths(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,start_node,end_node,map_node_positions,max_time,plot_path)

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

end