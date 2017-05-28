function lmr_batch(number_of_runs)
    % Function to run LMR algorithm simulations
    for run=1:number_of_runs
        fprintf('\n')
        fprintf('\n')
        fprintf('LMR batch - Run %d \n',run)
        lmr
    end
end