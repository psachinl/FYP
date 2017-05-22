function [group_transmission_time,power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time)
    % Function to calculate the overall transmission time for the
    % simulation and the total power consumption
    
    if first_transmission_time > 0 && last_transmission_time > 0
        group_transmission_time = last_transmission_time - first_transmission_time;
    else
        % -1 indicates the message has not fully propagated within the test
        % group
        group_transmission_time = -1;
    end
    
    % TODO: Write a function to calculate the total power consumption for
    % the test group
    power_consumption = -1;

    if print_timing_result
        fprintf('Group %d overall transmission time = %d seconds \n',test_group,group_transmission_time)
    end

    if print_power_result
        % TODO: Write a function to calculate the total power consumption of
        % the simulation
    end
end