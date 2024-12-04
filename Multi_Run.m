%% MULTI-RUN SIMULATION %%

    clearvars;
    clc;
    
% Set up variables, paramters, etc
        [areaWidth, areaHeight, droneSpeed, maxSearchRadius, timeStep, simulation_flag, numDrones, num_verify, showcase, percentFaulted, chanceOfFalsePositive, sim_count, droneInfo, stats, potentialFindsMatrix, verify_wait_time, targetSpeed] = setup_Simulation(); % Sets up variables etc
        numRuns = 20; % Specifies the number of runs
        showcase = false; %visualize or not
        
        % changing variables for testing:
            verify_type = "Turtle"; % "None", "NDrones", or "Turtle", or "Standard"
            percentFaulted = 75;
            % No verification
                
            % N Drone
                num_verify = 4;
            % Turtle-Based
                
            % Standard
            
        stats_array = cell(numRuns,1); % Initialize the cell aray for the stats from each simulation
        
% Globals (USE ONLY FOR STATS - Globals are bad practice) - TODO
global accum_stats;
accum_stats = zeros(10,10);
global time_failures;
time_failures = 0;
        
%% Sim Runs %%
for i = 1:numRuns
    disp(['Running Sim #' num2str(i) ' ... ' num2str(numRuns-i) ' Sims remaining']);
    % Individual stats (debug)
        stats = SimulationMain(areaWidth, areaHeight, droneSpeed, maxSearchRadius, timeStep, simulation_flag, numDrones, num_verify, showcase, percentFaulted, chanceOfFalsePositive, sim_count, droneInfo, stats, potentialFindsMatrix, verify_wait_time, targetSpeed, verify_type);
    % Summarized stats (normal) % TODO
        stats_array{i,1} = stats;
end
disp("All Simulation Runs Complete");
    
%% Output Parsing %%
avg_stats = zeros(10,10);
avg_stats = averageStats(avg_stats, numRuns);
total_TTF = 0;
successes = 0;

% Iterate through each matrix in stats_array
for i = 1:numel(stats_array)
    % Extract the matrix from the cell array
    current_matrix = stats_array{i};
    
    % Check if the cell (5, 8) in the current matrix is "Yes"
    if string(current_matrix(5, 8)) == "Yes"
        % Increment the counter if the condition is met
        successes = successes + 1;
    end
    
    
    % Add the value of the cell (2, 8) in the current matrix to the sum
    % (only for successes, counting TTF for failures skews data
    if string(current_matrix(5, 8)) == "Yes"
        total_TTF = total_TTF + cell2mat(current_matrix(2, 8));
    end
end

percentSuccess = (successes/numRuns) * 100;
avg_TTF = total_TTF/successes; %divide by successes, not totalRuns
disp(avg_TTF);
disp(percentSuccess);





