function [initial_power_consumption,final_power_consumption] = calculatePowerConsumption(nodes,test_group,number_of_stationary_nodes,nodes_per_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption)
    % Function to calculate power consumption for the test group at various
    % points in the simulation
    
    if first_transmission_time > 0 && initial_power_consumption < 0
        % First transmission has occurred, calculate power consumption for 
        % the test group at this point
        initial_power_consumption = 0;
        
        % Start index and end index are the node id's of the first and last nodes
        % within the test group
        start_index = number_of_stationary_nodes + (test_group-1) * nodes_per_group + 1;
        end_index = start_index + nodes_per_group - 1;
        
        for i=start_index:end_index
            initial_power_consumption = initial_power_consumption + nodes{i}.power_consumption;
        end
    end
    
    if last_transmission_time > 0 && final_power_consumption < 0
        % All nodes in test group have received the message, calculate
        % power consumption at this point
        
        final_power_consumption = 0;
        
        start_index = number_of_stationary_nodes + (test_group-1) * nodes_per_group + 1;
        end_index = start_index + nodes_per_group - 1;
        
        for i=start_index:end_index
            final_power_consumption = final_power_consumption + nodes{i}.power_consumption;
        end
    end
end