function [start_and_end,waypoints,main_path,overall_path] = move2Waypoint(node,waypoint,map_node_positions)

start_pos = node.current_position;
end_pos = [map_node_positions(waypoint,1),map_node_positions(waypoint,2)];

map_path = [start_pos;end_pos];

[start_and_end,waypoints,main_path] = getMovement([0,0],node.min_speed,node.max_speed,map_node_positions,map_path);
overall_path = [start_and_end(1,:); main_path; start_and_end(end,:)];
