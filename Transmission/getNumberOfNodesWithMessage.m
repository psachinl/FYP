function num_nodes = getNumberOfNodesWithMessage(nodes,test_group,number_of_stationary_nodes,nodes_per_group)
    % Function that returns the number of nodes in a test group which have
    % received the message
    
    % Start node and end node are the node id's of the first and last nodes
    % within the test group
    start_node = number_of_stationary_nodes + (test_group-1) * nodes_per_group + 1;
    end_node = start_node + nodes_per_group;
    
    num_nodes = 0; % Initialise number of nodes with message to 0
    
    for i=start_node:end_node
        if nodes{i}.message_to_transmit
            num_nodes = num_nodes + 1;
        end
    end
    
end