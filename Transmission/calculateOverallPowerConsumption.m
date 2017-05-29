function overall_power_consumption = calculateOverallPowerConsumption(nodes,number_of_stationary_nodes,test_group,nodes_per_group)
    % Function to calculate overall power consumption for the test group
    % including the power consumption incurred after all nodes in the test
    % group have received the message
    
    overall_power_consumption = 0;
        
    % Start index and end index are the node id's of the first and last nodes
    % within the test group
    start_index = number_of_stationary_nodes + (test_group-1) * nodes_per_group + 1;
    end_index = start_index + nodes_per_group - 1;

    for i=start_index:end_index
        overall_power_consumption = overall_power_consumption + nodes{i}.power_consumption;
    end
end