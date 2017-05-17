function nodes = stationary2MovingTransmission(nodes,number_of_stationary_nodes,number_of_nodes,edge_start_points,edge_end_points,edge_weights,end_node,new_exit_point,map_node_positions,debug,t)
    % Method to transmit messages from stationary nodes to moving nodes
    
    for src=1:number_of_stationary_nodes
        if nodes{src}.message_to_transmit
            for dest=1+number_of_stationary_nodes:number_of_nodes
                if nodes{src}.checkBTRange(nodes{dest}) && ~nodes{dest}.message_to_transmit
                    [nodes{src},nodes{dest}] = nodes{src}.transmit(nodes{dest});

                    % Remove duplicates that were added to avoid indexing
                    % errors
                    nodes{dest} = removeDuplicates(nodes{dest});
                    
                    % Calculate path to new exit point, update node
                    % end_point
                    [start_and_end,waypoints,main_path] = SPMBM(edge_start_points,edge_end_points,edge_weights,end_node(nodes{dest}.group),new_exit_point,nodes{dest}.min_speed,nodes{dest}.max_speed,map_node_positions);
                    start_and_end(1,:) = nodes{dest}.start_point; % Keep original start point
                    nodes{dest}.end_point = start_and_end(2,:);
                    
                    % Append overall path to existing path
                    overall_path = [main_path; start_and_end(end,:)];
                    nodes{dest}.position{4} = [nodes{dest}.position{4};overall_path];
                    
                    % Update remaining position cells
                    nodes{dest}.position{1} = start_and_end;
                    nodes{dest}.position{2} = [nodes{dest}.position{2};waypoints];
                    nodes{dest}.position{3} = [nodes{dest}.position{3};main_path];
                    
                    if debug
                        fprintf('Time = %d \n',t);
                        fprintf('Node %d position changed after transmission from node %d \n',dest,src);
                        fprintf('Node %d position{4} length = %d \n',dest,length(nodes{dest}.position{4}));
                    end
                end
            end
        end
    end
end