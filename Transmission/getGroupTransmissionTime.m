function overall_time = getGroupTransmissionTime(nodes,test_group,t,number_of_moving_groups,nodes_per_group,number_of_stationary_nodes)
    % Function to measure the time taken for all the relevant nodes in the
    % simulation to receive the message. The overall transmission time here
    % is defined as the time difference between the first and last nodes in 
    % a group receiving the message
    
    % Inputs: - Cell array nodes containing all the nodes in the simulation
    %         - Group number of the group in question
    %         - Time slice t
    %         - The number of moving groups in the simulation
    %         - The number of nodes per moving group of nodes
    %         - The number of stationary nodes in the simulation
    
    % Outputs: - Time in seconds between the first and last nodes in the
    %            group receiving the message
    
    for m = 1:number_of_moving_groups
        for n = 1:nodes_per_group
            index = n + (m-1)*nodes_per_group + number_of_stationary_nodes;
            
            if nodes{index}.group == test_group
                
            end
            
        end
    end
end