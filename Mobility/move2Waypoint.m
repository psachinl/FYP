function [start_and_end,waypoints,main_path,overall_path,waypoint] = move2Waypoint(node,map_node_positions)

min_distance = 1e10;

for i=1:length(map_node_positions)
    % norm gives the Euclidean length of the vector 
    distance_to_waypoint = abs(norm(map_node_positions(i,:) - node.current_position));
    
    if distance_to_waypoint < min_distance
        min_distance = distance_to_waypoint;
        waypoint=i;
    end
end

% fprintf('Nearest waypoint = %d\n',waypoint);

start_pos = node.current_position;
end_pos = [map_node_positions(waypoint,1),map_node_positions(waypoint,2)];

map_path = [start_pos;end_pos];

[start_and_end,waypoints,main_path] = getMovement([0,0],node.min_speed,node.max_speed,map_node_positions,map_path);
overall_path = [start_and_end(1,:); main_path; start_and_end(end,:)];
