function stats = SimulationMain(areaWidth, areaHeight, droneSpeed, maxSearchRadius, timeStep, simulation_flag, numDrones, num_verify, showcase, percentFaulted, chanceOfFalsePositive, sim_count, droneInfo, stats, potentialFindsMatrix, verify_wait_time, targetSpeed, verify_type)
%% INITIALIZATION %%
    % clearvars;
    % clc;
    global accum_stats;
    global time_failures;
    reset(RandStream.getGlobalStream,sum(100*clock));
    
    % Set up variables, paramters, etc
        %[areaWidth, areaHeight, droneSpeed, maxSearchRadius, timeStep, simulation_flag, numDrones, num_verify, showcase, percentFaulted, chanceOfFalsePositive, sim_count, droneInfo, targetLocation, stats, potentialFindsMatrix, verify_wait_time, targetSpeed] = setup_Simulation(); % Sets up variables etc
       
        % debug
        showcase_debug = false;
        showcase_delay = 0.1;
        %verify_type = "Turtle";
        
%% OTHER INIT %%
    
    % Pre-Simulation Tasks
        % Set up grid coordinates for a possible* grid search
            droneInfo = setup_Grid_updated(areaHeight, areaWidth, numDrones, droneInfo);
        % Initialize the matrix for tracking drone trails (purely visual)
            droneTrails = cell(numDrones, 1);
            [droneInfo, numFaulted] = setup_Faulted(droneInfo, percentFaulted);
        % Pre-populate Statistics with static parameters
            stats = setup_Stats(stats, percentFaulted, numDrones, maxSearchRadius, droneSpeed, areaHeight, areaWidth, numFaulted, timeStep); % Set up stats matrix
            
        % Target randomness (needs to change each sim
            targetLocation = [rand*areaWidth, rand*areaHeight]; % Random initial position
            %targetLocation = [areaWidth/3, areaHeight/3]; % Close initial position for testing
%% Main Simulation Loop %%
    while simulation_flag % Run the simulation while the flag is true
        sim_count = sim_count + 1 ; % Increment the sim count
        
        % Update drone positions (pure movement)
            % Random movement
                % droneInfo = moveDrones_Random(droneInfo, droneSpeed, timeStep);
            % Grid movement
                for currentDrone = 1:size(droneInfo) 
                    [droneInfo, potentialFindsMatrix] = moveDrones_Grid(droneInfo, currentDrone, droneSpeed, timeStep, verify_wait_time, potentialFindsMatrix, verify_type, chanceOfFalsePositive);
                end
        % Update target position (randomly move)
                targetLocation = moveTarget_Random(targetLocation, timeStep, targetSpeed, areaHeight, areaWidth);
        
        % Check for find
            if verify_type == "None" % Regular checkForFind, no verification
                [simulation_flag,stats] = checkForFind_noVerification(droneInfo, targetLocation, maxSearchRadius, stats, chanceOfFalsePositive);
                simulation_flag = ~simulation_flag;
            elseif verify_type == "NDrones" % checkForFind with x drone verification
                [potentialFindsMatrix, stats, droneInfo, simulation_flag] = checkForFind_NDroneVerification(droneInfo, targetLocation, maxSearchRadius, num_verify, stats, chanceOfFalsePositive, potentialFindsMatrix);
            elseif verify_type == "Turtle" % TURTLE BASED - BUFFER VERIFICATION - TODO
                droneInfo = updateDroneSectors(droneInfo, areaHeight, areaWidth);
                [potentialFindsMatrix, stats, droneInfo, simulation_flag] = checkForFind_TurtleBased(droneInfo, targetLocation, maxSearchRadius, num_verify, stats, chanceOfFalsePositive, potentialFindsMatrix);
            elseif verify_type == "Standard" % Standard Consensus Algorithm
                [potentialFindsMatrix, stats, droneInfo, simulation_flag] = checkForFind_StandardConsensus(droneInfo, targetLocation, maxSearchRadius, num_verify, stats, chanceOfFalsePositive, potentialFindsMatrix);                
            else
                disp("Verification method not set correctly");
            end
                
        %  Store historical positions for trails
            droneTrails = updateTrails(droneTrails, droneInfo);

        % Visualize the simulation with droneTrails as an argument
        % *Only if the simulation is running for another time step
        % *Only if the showcase mode is on
            if simulation_flag && (showcase || showcase_debug)
                visualizeSimulation(areaWidth, areaHeight, targetLocation, droneInfo, droneTrails);
            end
            
        % Pause to visualize each step if showcase mode is on
        if showcase && ~showcase_debug
            pause(0.1);
        elseif showcase_debug
            pause(showcase_delay);
        end
        
        % End if its taking over 168 hours (effectively a fail
        if sim_count > (168*6) % 168*6 = 168 hours in sim_counts
            stats{5,8} = "No"; % Record successful scenario
            simulation_flag = false;
            disp("SAR took over a week, effective failure");
            time_failures = time_failures + 1;
        end
        
    end
    
    % Sim over, record Time To Find
    stats{2,8} = sim_count;
    accum_stats(2,8) = sim_count;
end