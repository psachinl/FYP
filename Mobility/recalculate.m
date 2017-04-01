function [start_and_end,waypoints,main_path] = recalculate(edge_start_points,edge_end_points,W,start_node,end_node,min_speed,max_speed,map_node_positions,remaining_positions)

path = getPath(edge_start_points,edge_end_points,W,start_node,end_node);
[start_and_end,waypoints,main_path] = getMovement(path,min_speed,max_speed,map_node_positions);

start_and_end(1,1) = remaining_positions(1,1);
start_and_end(1,2) = remaining_positions(1,2);

main_path = [remaining_positions;main_path];
waypoints = [remaining_positions(end,1),remaining_positions(end,2);waypoints];
