function num_nodes = getNumberOfNodesWithMessage(nodes,test_group,number_of_stationary_nodes,nodes_per_group)
    % Function that returns the number of nodes in a test group which have
    % received the message
    
    % Start index and end index are the node id's of the first and last 
    % nodes within the test group
    start_index = number_of_stationary_nodes + (test_group-1) * nodes_per_group + 1;
    end_index = start_index + nodes_per_group - 1;
    
    num_nodes = 0; % Initialise number of nodes with message to 0
    
    for i=start_index:end_index
        if nodes{i}.message_to_transmit
            num_nodes = num_nodes + 1;
        end
    end
    
end