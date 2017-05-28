function reactive_delay_batch(number_of_runs)
    % Function to run reactive_delay algorithm simulations
    for run=1:number_of_runs
        fprintf('\n')
        fprintf('\n')
        fprintf('Reactive Delay batch - Run %d \n',run)
        reactive_delay
    end
end