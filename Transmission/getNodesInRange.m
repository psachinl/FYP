function in_range = getNodesInRange(src_node_id,nodes,number_of_stationary_nodes,number_of_nodes)
    
    % This function returns a vector containing the node id's of nodes
    % within BLE range of the specified source node without the use of a
    % location table. No location table is used on the assumption that
    % destination nodes will receive packets automatically and process them
    % as required
    
    in_range = []; % Array to store all nodes in BLE range of src_node
    
    for dest=1+number_of_stationary_nodes:number_of_nodes
        if dest ~= src_node_id && checkBTRange(nodes{src_node_id},nodes{dest}) && ~nodes{dest}.message_to_transmit
            in_range(length(in_range) + 1) = nodes{dest}.id;
        end
    end

end