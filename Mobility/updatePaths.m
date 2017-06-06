function dest = updatePaths(dest,map_node_positions,edge_start_points,edge_end_points,edge_weights,new_exit_point,t,max_time)
    % Calculate path to nearest waypoint
    [~,waypoints_w,main_path_w,overall_path_w,nearest_waypoint] = move2Waypoint(dest,map_node_positions);

    % Calculate path from nearest waypoint to new exit point
    [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,edge_weights,nearest_waypoint,new_exit_point,dest.min_speed,dest.max_speed,map_node_positions);
    overall_path = [start_and_end(1,:); main_path; start_and_end(end,:)];

    % Combine paths to find overall path, update end_point
    start_and_end(1,:) = dest.start_point; % Keep original start point
    dest.end_point = start_and_end(2,:);
    waypoints = [waypoints_w;waypoints];
    main_path = [main_path_w;main_path];
    overall_path = [overall_path_w;overall_path];

    % Remove duplicates that were added to avoid indexing errors
    dest = removeDuplicates(dest);

    % Truncate paths so remaining steps are removed
    dest.position{4} = dest.position{4}(1:t,:);
    dest.position{3} = dest.position{3}(1:t-1,:);

    % Append new path to existing node path
    dest.position{4} = [dest.position{4};overall_path];
    
    % Extend paths to avoid indexing errors
    while length(dest.position{4}) < max_time
        dest.position{4}(end+1,:) = dest.position{4}(end,:);
    end

    % Update remaining position cells
    dest.position{1} = start_and_end;
    dest.position{2} = [dest.position{2};waypoints];
    dest.position{3} = [dest.position{3};main_path];
end
