function packet_error_rate = calculatePacketErrorRate(nodes,test_group,number_of_stationary_nodes,nodes_per_group,print_packet_error_rate)
    % Function to calculate packet error rate as a percentage for the LMR 
    % algorithm 
    
    failed_transmissions = 0;
    completed_transmissions = 0;
    
    % Start index and end index are the node id's of the first and last 
    % nodes within the test group
    start_index = number_of_stationary_nodes + (test_group-1) * nodes_per_group + 1;
    end_index = start_index + nodes_per_group - 1;
    
    for i=start_index:end_index
        failed_transmissions = failed_transmissions + nodes{i}.failed_transmissions;
        completed_transmissions = completed_transmissions + nodes{i}.packets_transmitted;
    end
    
    % Completed + failed transmissions = total attempted transmissions
    % Multiply by 100 to get packet error rate as a percentage
    packet_error_rate = (failed_transmissions / (completed_transmissions + failed_transmissions)) * 100;
    
    if print_packet_error_rate
       fprintf('Group %d packet transmission error rate = %d %% \n',test_group,packet_error_rate)
    end
    
end
