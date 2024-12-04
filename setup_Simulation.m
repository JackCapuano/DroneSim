function [areaWidth, areaHeight, droneSpeed, maxSearchRadius, timeStep, simulation_flag, numDrones, num_verify, showcase, percentFaulted, chanceOfFalsePositive, sim_count, droneInfo, stats, potentialFindsMatrix, verify_wait_time, targetSpeed] = setup_Simulation()

%% SIMULATION PARAMETERS %%
    % Area dimensions
        areaWidth = 8;  % in miles
        areaHeight = 15; % in miles
    
    % Simulation Parameters
        sim_count = 0; % simulation time counter
        timeStep = 0.1; % time step (one simulation cycle) (in hours)
        simulation_flag = true; % flag to turn simulation on or off
        numDrones = 120; % Number of drones
        num_verify = 5; % Number of drones needed to verify (after initial find)
        showcase = false; % Show the simulation step/step (true) or fast mode (false)
    
%% DRONE PARAMETERS %%
    % Drone parameters
        droneSpeed = 8; % Speed of the drones (in mph when timeStep is 0.1)
        maxSearchRadius = 0.75; % Maximum search radius (in miles) 
        
    % Faulted parameters
        percentFaulted = 10; % Percent of drones that are faulted
        chanceOfFalsePositive = 0.1; % Percent chance per drone, per time step, of reporting a false positive
        verify_wait_time = 10; % Number of time steps to wait at a verify location
    
%% TARGET PARAMETERS %%
    % Target parameters
        targetLocation = [rand*areaWidth, rand*areaHeight]; % Random initial position
        %targetLocation = [areaWidth/3, areaHeight/3]; % Close initial position for testing
        targetSpeed = 0.1;

%% MATRIX INIT %%
    % Main matrix - droneInfo - used for drone information (location, etc)
        droneInfo = zeros(numDrones, 19); % Init to 0
        droneInfo(:, 14) = 1; % Set the standard grid_location to 1
        droneInfo(:, 3) = 0; % Set the standard reset_status to 0
        
        % Drone start parameters
            % Random start
                % droneInfo = rand(numDrones, 2) .* [areaWidth, areaHeight];
            % Center start 
                droneInfo(:, 1) = areaWidth/2;
                droneInfo(:, 2) = areaHeight/2;
        
    % Statistics matrix - used for recording statistics to be output
        stats = cell(10,10); % Init to 0
        
    % Potential Finds Matrix - used for X drone verification 
        potentialFindsMatrix = zeros(numDrones, 5); % Init potentialFindsMatrix
        
end

