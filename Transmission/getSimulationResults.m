function [group_transmission_time,power_consumption] = getSimulationResults(print_timing_result,print_power_result,test_group,first_transmission_time,last_transmission_time,initial_power_consumption,final_power_consumption,overall_power_consumption,nodes_per_group)
    % Function to calculate the overall transmission time for the
    % simulation and the total power consumption
    
    if first_transmission_time > 0 && last_transmission_time > 0
        group_transmission_time = last_transmission_time - first_transmission_time;
    else
        % -1 indicates the message has not fully propagated within the test
        % group
        group_transmission_time = -1;
    end
    
    % Calculate power consumption for just the message transmission period
    transmission_power_consumption = final_power_consumption - initial_power_consumption;
    average_transmission_power_consumption = transmission_power_consumption / nodes_per_group;
    power_consumption = {initial_power_consumption,final_power_consumption,transmission_power_consumption,overall_power_consumption,average_transmission_power_consumption};

    if print_timing_result
        fprintf('Group %d overall transmission time = %d seconds \n',test_group,group_transmission_time)
    end

    if print_power_result
        fprintf('Group %d transmission power consumption = %d \n',test_group,transmission_power_consumption)
        fprintf('Group %d average transmission power consumption = %d \n',test_group,average_transmission_power_consumption)
        fprintf('Group %d initial power consumption = %d \n',test_group,initial_power_consumption)
        fprintf('Group %d final power consumption = %d \n',test_group,final_power_consumption)
        if overall_power_consumption > 0
            fprintf('Group %d overall power consumption = %d \n',test_group,overall_power_consumption)
        end
    end
end