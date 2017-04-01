function [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,W,start_node,end_node,min_speed,max_speed,map_node_positions)

path = getPath(edge_start_points,edge_end_points,W,start_node,end_node);
[start_and_end,waypoints,main_path] = getMovement(path,min_speed,max_speed,map_node_positions);
