function [first_transmission_time,last_transmission_time] = storeTransmissionTimes(nodes,test_group,number_of_stationary_nodes,nodes_per_group,first_transmission_time,last_transmission_time,t)
    % Function to store the first and last transmission times within a
    % group so overall transmission time can be calculated
    
    % Two if statements are used rather than an if..elseif statement since
    % for sparse networks, all the nodes in a group may receive the message
    % within the same time slice so both conditions can be true
    if getNumberOfNodesWithMessage(nodes,test_group,number_of_stationary_nodes,nodes_per_group) == nodes_per_group && last_transmission_time == -1
        last_transmission_time = t;
    end
    if getNumberOfNodesWithMessage(nodes,test_group,number_of_stationary_nodes,nodes_per_group) > 0 && first_transmission_time == -1
        first_transmission_time = t;
    end
end